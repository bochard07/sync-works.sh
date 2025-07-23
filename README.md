# sync-works.sh
Update Git submodules on a final directory and removing the `.git` file.

## How it works?
1. Read the list of submodules in the `works-list.txt` file.
2. Creates two directory: `works-tmp/` and `works/`.
2. Checks if submodules from the txt file exists within `works-tmp` folder. If not, add it.
3. Update the submodules in their remote latest commit.
4. Copy the submodules from the `works-tmp` directory to the `works` directory while removing `.git` contents simultaneously.
5. Automatically stage and commit the changes.

## How to use?
1. Open the directory
```
cd path/to/sync-works.sh/
```
2. Copy to your project
```
cp './sync-work.sh' 'path/to/your/project/'
```
3. Give permission to execute
```
chmod +x ./sync-works.sh
```
4. Then, run...
```
./sync-works.sh
```
5. Enjoy!

---
