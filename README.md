# sync-works.sh
Update Git submodules on a final directory and removing the `.git` file.

## process...
1. Read the list of submodules in the `works-list.txt` file.
2. Checks if submodules from the txt file exists within `works-tmp` folder. If not, add it.
3. Update the submodules in their remote latest commit.
4. Copy the submodules from the `works-tmp` directory to the `works` directory while removing `.git` contents simultaneously.
5. Automatically stage and commit the changes.