# Lifecyle tools presentation

## Bullet List of Points to Cover
#### How Claude helped me setup the structure of the project
* Helper Understand how to create a Man build python package
* Took slack and some links and a doc and put together a guideline
*  Stored it in my personal claude folder

#### SHow how the build works and exists in man build

#### How I use Claude.md to put a standardised tracking on every session in a project 
* Folder for docs and folder for session tracking. A file 


### Structure 
Ever client provides responseses in json to enable maximum compatibility with tooling clients. Every cli command has a --json-output flag which shows exactly what the python client function returns 


The cli picks up the json and formats for the command line
I wanted to have a small set of project specific wrappers around tool apis 
My thinking was that I can't be sure how I want to use these. The space of AI engineering is moving so fast that if I coupled everything to MCP then by now I would need a re-write as we move more to skills. I also was now sure if I want to use a command line tool or a streamlit page or a Jupyter notebook so I went with these small composable functions that wrap the tool APIS and layer a little bit of OMS specificity on top 

It may be some of this logic could be done using mcps or but these functions are specific to the oms release workflow 

## ToDo 
1. Make sure to include platform Jiras and projects. 
2. Make the project user typer and rich. Explain what they are 