# 🛠️ ViteForge

ViteForge is a powerful CLI tool that instantly forges production-ready React development environments. Skip the tedious setup and jump straight into building your next great project.

## ✨ Features

- 🚀 Vite-powered React setup with TypeScript
- 🎨 Tailwind CSS + PostCSS pre-configured
- 🔍 Full VSCode debugging support
- ✅ ESLint + Prettier code quality tools
- 🧪 Vitest testing framework
- 📁 Optimized project structure
- 🎯 TypeScript path aliases
- 🐛 Advanced debugging configurations

## 🚀 Quick Start

1. Download the script:
```bash
curl -O https://raw.githubusercontent.com/gbasilveira/scripts/viteforge/main/viteforge.sh
```

2. Make it executable:
```bash
chmod +x viteforge.sh
```

3. Run ViteForge:
```bash
# With project name
./viteforge.sh my-awesome-project

# Without project name (interactive mode)
./viteforge.sh
```

## 🏗️ What's Included

### Project Structure
```
your-project/
├── src/
│   ├── components/
│   ├── layouts/
│   ├── pages/
│   ├── hooks/
│   ├── utils/
│   ├── types/
│   └── stores/
├── .vscode/
│   ├── launch.json
│   └── settings.json
└── [Configuration Files]
```

### Development Tools
- **Vite**: Lightning-fast build tooling
- **React**: Latest React with TypeScript support
- **Tailwind CSS**: Utility-first CSS framework
- **ESLint**: Code quality and style enforcement
- **Prettier**: Code formatting
- **Vitest**: Unit testing framework
- **TypeScript**: Type safety and developer experience

### Scripts
```bash
npm run dev         # Start development server
npm run build      # Build for production
npm run preview    # Preview production build
npm run lint       # Run ESLint
npm run format     # Format code with Prettier
npm run type-check # Check TypeScript types
npm run test       # Run tests
npm run test:ui    # Run tests with UI
npm run coverage   # Generate test coverage
```

## 🔧 VSCode Integration

ViteForge automatically configures VSCode for an optimal development experience:

- Debugging configurations for both frontend and tests
- Format on save
- ESLint integration
- Recommended extensions

### Recommended Extensions
- ESLint
- Prettier
- Chrome Debugger
- TypeScript and JavaScript Language Features

## 🎯 Path Aliases

Use the `@` alias to import from the `src` directory:
```typescript
// Instead of
import { Button } from '../../../components/Button'

// Use
import { Button } from '@/components/Button'
```

## 🐛 Debugging

Launch configurations are included for:
- Chrome debugging against localhost
- Vitest test debugging

To start debugging:
1. Open your project in VSCode
2. Press F5 or use the Run and Debug panel
3. Select the appropriate debug configuration

## 📦 Dependencies

### Production
- React
- React DOM
- clsx (utility for constructing className strings)
- @heroicons/react (Icon library)
- dayjs (Date utility library)

### Development
- TypeScript
- Vite
- Tailwind CSS
- PostCSS
- ESLint
- Prettier
- Vitest
- Testing Library

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by modern React development best practices
- Built on the shoulders of amazing open-source tools

---

Happy coding! 🚀
