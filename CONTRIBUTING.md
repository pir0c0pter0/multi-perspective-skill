# Contributing to Multi-Perspective Skill

First off, thank you for considering contributing! 🎉

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](https://github.com/mariostjr/multi-perspective-skill/issues)
2. If not, create a new issue with:
   - Clear title describing the problem
   - Steps to reproduce
   - Expected vs actual behavior
   - Your environment (OS, Claude Code version)

### Suggesting Features

1. Open an issue with the `enhancement` label
2. Describe the feature and its use case
3. Explain why it would be useful

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Test your changes locally
5. Commit with clear message: `git commit -m "feat: add my feature"`
6. Push to your fork: `git push origin feature/my-feature`
7. Open a Pull Request

### Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation only
- `refactor:` Code refactoring
- `test:` Adding tests
- `chore:` Maintenance

### Code Style

- Keep templates clear and concise
- Use consistent formatting in YAML
- Document any non-obvious behavior

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/multi-perspective-skill.git

# Create a symlink for testing
ln -s $(pwd)/multi-perspective-skill ~/.claude/skills/skills/multi-perspective

# Test your changes
/multi-perspective "test prompt"
```

## Questions?

Open a [Discussion](https://github.com/mariostjr/multi-perspective-skill/discussions) for questions or ideas.

Thank you for contributing! 🙏
