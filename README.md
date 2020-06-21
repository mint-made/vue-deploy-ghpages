## Shell Script Automation to Create and Deploy VueJS projects to Github Pages
A shell script to automate the creation and deployment of a new VueJS project, with the project automatically hosted on Github Pages.

### Requirements
- Vue CLI

### Project Setup

1. Clone the project and make the script exectuable
2. Create a new Github repository for your project
3. Run the script in the directory you want to create your new project
4. Enter the project name (should be the same as the Github repository name)
5. Enter your Github credentials, when prompted by the terminal
6. When finished the script will open your project in VS Code if you have it installed

### Post setup - Updating Github Pages using the deploy.sh script

The script builds a deploy.sh script in your VueJS project directory. After you have built content in your VueJS project and want to update the Github Pages simply run:

```
./deploy.sh
```

This will build your project into the /dist/ folder and the files within this directory are pushed to the gh-pages branch of your VueJS project on Github, updating your Github Page site.
