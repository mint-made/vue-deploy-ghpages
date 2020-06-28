#!/usr/bin/env bash

# display important information to the user
echo "A new Vue project will be created and deployed to your Github Pages."
echo "Before proceeding, create a new Github repository for the project."
echo

# let the user give a name to the project
read -p "Github Repository Name: " varName

# let the user input their github name
read -p "Github Account Name(for project to be hosted): " varGithubAccount

# check if site is being hosted in the github root <username>/github.io or a repo <username>/github.io/<repo>
varURL="${varGithubAccount}.github.io"
echo $varName
echo $varURL

if [[ "$varName" == "$varURL" ]]; then
  echo "match"
else
  echo "no match"
fi

