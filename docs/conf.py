# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'vlsi_be_labs'
copyright = '2024, Yuri Korotaev'
author = 'Yuri Korotaev'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'myst_parser',
]

# Enable Markdown source file support
source_suffix = {
    '.rst': 'restructuredtext',
    '.md': 'markdown',
}

# Optional: Auto-generate TOC tree in your Markdown files
#from recommonmark.transform import AutoStructify

#def setup(app):
#    app.add_config_value('recommonmark_config', {
#            'url_resolver': lambda url: github_doc_root + url,
#            'auto_toc_tree_section': 'Contents',
#            }, True)
#    app.add_transform(AutoStructify)

myst_enable_extensions = [
    "deflist",
    "dollarmath",
    "colon_fence",
]

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']



# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'alabaster'
html_static_path = ['_static']
