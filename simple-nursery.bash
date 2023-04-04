#!/bin/bash

echo "This script requires go 1.20+ and the github command line tools."
echo "You can get the github command line tools here: https://cli.github.com/"
echo "You can download Go here: https://go.dev/dl/"

# Accept the name of a new project from the user
read -p "Enter the name of your new project (lowercase letters only): " new_project_name

# Validate that the new project name is only lowercase letters a-z
if [[ ! "$new_project_name" =~ ^[a-z]+$ ]]; then
  echo "Error: The new project name can only contain lowercase letters a-z."
  exit 1
fi

# Clone the nursery repository into a folder with the name of the new project
git clone https://github.com/notional-labs/nursery.git "$new_project_name"

# Change every instance of the word "nursery" in the new repository into the name of the new project
cd "$new_project_name" || exit
find . -type f -name "*" -print0 | xargs -0 sed -i "" "s/nursery/$new_project_name/g"

# Move cmd/nurseryd to cmd/$new_project_name
mv cmd/nurseryd cmd/"$new_project_name"

# Run gh repo fork --fork-name $new_project_name --remote from inside the new project's folder
gh repo fork --fork-name "$new_project_name" --remote

# Inform the user that they now only need to commit and push the code to their new repository
echo "Congratulations! Your new project '$new_project_name' has been created on GitHub."
echo "You now only need to commit and push the code to your new repository using the following commands:"
echo ""
echo "git add ."
echo "git commit -m 'Initial commit'"
echo "git push origin main"
