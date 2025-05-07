# brick-scripts


- Make sure `brick.sh` is executable
- Add `brick.sh` to your shell rc file as an alias  

```bash
chmod +x brick.sh
echo "alias brick=\"$(find ~+ -type f -name brick.sh)\"" >> ~/.zshrc
```
