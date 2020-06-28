## Shell Script Automation to Create and Deploy VueJS projects to Github Pages

### Project Description

A shell script to automate the creation and deployment of a new VueJS project, with the project automatically hosted on Github Pages.

### Requirements

- vue-cli
- node/npm

### What the script does

- Creates your vue project using the vue-cli setup
- Creates a vue.config.js file with a public path matching your project name if you are hosting at https://*USERNAME*.github.io/*REPO*
- Creates a deploy.sh script, with different commands depending on how you are hosting; with a custom domain, at https://*USERNAME*.github.io/ or at https://*USERNAME*.github.io/*REPO*. The script builds the distribution files and pushes them to the right branch of the repo that is hosted.
- Edits the project README.md to includ the script.sh description and also adds a link to the hosted project

### Project Setup

1. Clone the project and make the script exectuable
2. Create a new Github remote repository for your project
3. Run the script in the directory you want to create your new project and follow the instructions in the terminal

### Post setup - Updating Github Pages using the deploy.sh script

The script builds a deploy.sh script in your VueJS project directory. After you have built content in your VueJS project and want to deploy the changes to your gh-pages, in the terminal run:

```
./deploy.sh
```

This will build your project into the /dist/ folder and the files within this directory are pushed to the gh-pages branch of your VueJS project on Github, updating your Github Page site.
