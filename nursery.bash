#!/bin/bash

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

# Check if the GitHub command line tools are installed, and install them if they aren't
if ! command -v gh &> /dev/null; then
  echo "GitHub command line tools are not installed."
  read -p "Would you like to install them? (y/n) " install_gh

  if [ "$install_gh" == "y" ]; then
    # Check if Homebrew is installed, and install it if it isn't
    if ! command -v brew &> /dev/null; then
      echo "Homebrew is not installed."
      read -p "Would you like to install it? (y/n) " install_brew

      if [ "$install_brew" == "y" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      else
        echo "Error: Homebrew is required to install the GitHub command line tools."
        exit 1
      fi
    fi

    brew install gh
  else
    echo "Error: The GitHub command line tools are required to continue."
    exit 1
  fi
fi

# Check if Go 1.20 is installed, and install it using Homebrew if it isn't
if ! command -v go &> /dev/null || ! go version | grep -q "go1.20"; then
  echo "Go 1.20 is not installed."
  read -p "Would you like to install it using Homebrew? (y/n) " install_go

  if [ "$install_go" == "y" ]; then
    brew install go@1.20
  else
    echo "Error: Go 1.20 is required to continue."
    exit 1
  fi
fi

# Run gh repo fork --fork-name $new_project_name --remote from inside the new project's folder
gh repo fork --fork-name "$new_project_name" --remote

# Inform the user that they now only need to commit and push the code to their new repository
echo "Congratulations! Your new project '$new_project_name' has been created on GitHub."
echo "You now only need to commit and push the code to your new repository using the following commands:"
echo ""
echo "git add ."
echo "git commit -m 'Initial commit'"
echo "git push origin main"
