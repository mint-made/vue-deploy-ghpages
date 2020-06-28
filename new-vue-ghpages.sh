#!/usr/bin/env bash

# display important information to the user
echo "A new Vue project will be created and deployed to your Github Pages."
echo "Before proceeding, create a new Github repository for the project."
echo

# let the user give a name to the project
read -p "Github Repository Name: " varName

# let the user input their github name
read -p "Github Account Name(for project to be hosted): " varGithubAccount

# check hosting location: <username>/github.io | <username>/github.io/<repo> | custom URL

if [[ "$varName" == "${varGithubAccount}.github.io" ]]; then
  read -p "Are you deploying the site to a custom domain (y/n)? " varYNCustomDomain
  if [[ "$varYNCustomDomain" == "y" ]]; then
    read -p "What is your custom domain? " varCustomDomain
  fi
fi

# create the project using the vue/cli
vue create $varName
cd $varName

# create a vue.config.js file and add a public path *not needed on github root / custom URL
if [[ "$varName" != "${varGithubAccount}.github.io" ]]; then
  echo "module.exports = {
    publicPath: process.env.NODE_ENV === 'production'
      ? '/${varName}/'
      : '/'
  }" >> vue.config.js
fi

# create a shell script to build the vue /dist files and deploy them to gh-pages branch to be hosted online
echo "#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist
" >> deploy.sh
## if you are deploying to a custom domain
if [[ "$varYNCustomDomain" == "y" ]]; then
  echo "# deploying to a custom domain
echo '${varCustomDomain}' >> CNAME
" >> deploy.sh
fi
echo "git init
git add -A
git commit -m 'deploy'
" >> deploy.sh
## if you are deploying to https://<USERNAME>.github.io
if [[ "$varName" == "${varGithubAccount}.github.io" ]]; then
  echo "# deploying to https://<USERNAME>.github.io
git push -f https://github.com/${varGithubAccount}/${varName}.git deployment
" >> deploy.sh
fi
## if you are deploying to https://<USERNAME>.github.io/<REPO>
if [[ "$varName" != "${varGithubAccount}.github.io" ]]; then
  echo "# deploying to https://<USERNAME>.github.io/<REPO>
git push -f https://github.com/${varGithubAccount}/${varName}.git master:gh-pages
" >> deploy.sh
fi
echo "cd -

# Vue project deployment information can be found at: https://cli.vuejs.org/guide/deployment.html#github-pages" >> deploy.sh

# add executable permissions to the deploy.sh file
chmod +x deploy.sh

# add information to the README.md file about how to run the command and the URL of where the project is hosted
if [[ "$varName" != "${varGithubAccount}.github.io" ]]; then
sed -i "22i\This project can be found at: https://${varGithubAccount}.github.io/${varName}" README.md
fi
if [[ "$varName" == "${varGithubAccount}.github.io" && "$varYNCustomDomain" != "y" ]]; then
sed -i "22i\This project can be found at: https://${varGithubAccount}.github.io/" README.md
fi
if [[ "$varName" == "${varGithubAccount}.github.io" && "$varYNCustomDomain" == "y" ]]; then
sed -i "22i\This project can be found at: https://$varCustomDomain" README.md
fi
sed -i '22i\### Github Pages' README.md
sed -i "22i\" README.md
sed -i '22i\```' README.md
sed -i "22i\./deploy.sh" README.md
sed -i '22i\```' README.md
sed -i "22i\### Builds and deploys the project to Github Pages" README.md
sed -i "22i\" README.md

# init, commit and push development files to master branch
git init
git add .
git commit -m "first commit"
git remote add origin https://github.com/mint-made/${varName}.git
git push -u origin master

# run deploy.sh script to build and then delpoy files to github pages
./deploy.sh

# open the project in vs code
code .