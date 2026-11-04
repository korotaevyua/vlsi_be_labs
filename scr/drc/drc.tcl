# Run in a NEW Magic session from work/drc:
# magic -dnull -noconsole -rcfile ../../scr/drc/sky130A.magicrc ../../scr/drc/drc.tcl

############################################################
# 1. Input GDS, top cell and output report
# Variables may also be set before sourcing this script.
if {![info exists input_gds]} {set input_gds ../gds/seven_segment_seconds.gds}
if {![info exists top_cell]} {set top_cell seven_segment_seconds}
if {![info exists report_file]} {set report_file seven_segment_seconds_drc.txt}
############################################################

# An incomplete run must not leave a report that looks like a pass.
set report_channel ""
if {[catch {
    if {[file normalize $report_file] eq [file normalize $input_gds]} {
        error "Report path must differ from the input GDS path"
    }
    set report_channel [open $report_file w]
    puts $report_channel "Status: RUNNING"
    puts $report_channel "Input GDS: [file normalize $input_gds]"
    puts $report_channel "Top cell: $top_cell"
    flush $report_channel

    if {![file isfile $input_gds] || ![file readable $input_gds]} {
        error "Input GDS is missing or unreadable: $input_gds"
    }
    if {[tech name] ne "sky130A"} {
        error "Expected technology sky130A, got [tech name]"
    }

    ############################################################
    # 2. Read the exported GDS (no DEF or existing MAG database)
    drc off
    if {[lsearch -exact [cellname list all] $top_cell] >= 0} {
        error "Top cell already loaded; start a fresh Magic session"
    }
    gds readonly true
    gds read $input_gds
    if {[lsearch -exact [cellname list all] $top_cell] < 0} {
        error "Top cell '$top_cell' was not found in the GDS"
    }
    load $top_cell

    # Flatten a temporary in-memory copy to check all geometry,
    # including standard cells and their interactions.
    set check_cell ${top_cell}__drc_flat
    if {[lsearch -exact [cellname list all] $check_cell] >= 0} {
        error "Cell '$check_cell' already exists; start a fresh Magic session"
    }
    flatten $check_cell
    load $check_cell
    select top cell
    box select
    ############################################################

    ############################################################
    # 3. Check the complete layout using the technology rules
    drc euclidean on
    drc style drc(full)
    if {[drc list style] ne "drc(full)"} {
        error "DRC style drc(full) is not available"
    }
    drc on
    drc check
    drc catchup
    set all_errors [drc listall why]
    ############################################################

    ############################################################
    # 4. Report rule descriptions and marker coordinates in um
    set scale [cif scale out]
    puts $report_channel "Technology: [tech name]"
    puts $report_channel "DRC style: [drc list style]"
    puts $report_channel "Coordinates: llx lly urx ury (um)"
    puts $report_channel "Scope: Magic geometry DRC; antenna and density checks are separate."

    set marker_count 0
    foreach {rule rectangles} $all_errors {
        puts $report_channel "\n$rule"
        foreach rect $rectangles {
            set coords {}
            foreach value $rect {
                lappend coords [format %.3f [expr {$value * $scale}]]
            }
            puts $report_channel [join $coords " "]
            incr marker_count
        }
    }
    set result [expr {$marker_count == 0 ? "PASS" : "FAIL"}]
    puts $report_channel "\nRule groups: [expr {[llength $all_errors] / 2}]"
    puts $report_channel "DRC markers: $marker_count"
    puts $report_channel "Status: $result"
    close $report_channel
    set report_channel ""
    puts "DRC $result: $marker_count markers. Report: $report_file"
} message]} {
    if {$report_channel ne ""} {
        puts $report_channel "Status: ERROR\n$message"
        close $report_channel
    }
    puts stderr "DRC ERROR: $message"
    exit 2
}

# 0 = clean, 1 = violations, 2 = execution/input error.
# Do not save the temporary flattened layout or rewrite the input GDS.
exit [expr {$marker_count == 0 ? 0 : 1}]
