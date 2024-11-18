#!/bin/bash

# ViteForge - Modern React Development Environment Setup
# Version: 1.0.0
# Author: Guilherme da Silveira
# License: MIT

# Function to prompt for project name if not provided
get_project_name() {
    if [ -z "$1" ]; then
        read -p "Enter project name: " project_name
    else
        project_name="$1"
    fi
    echo "$project_name"
}

# Get project name from command line argument or prompt
PROJECT_NAME=$(get_project_name "$1")

# Validate project name
if [[ ! $PROJECT_NAME =~ ^[a-zA-Z][-a-zA-Z0-9]*$ ]]; then
    echo "Error: Project name must start with a letter and contain only letters, numbers, and hyphens."
    exit 1
fi

echo "Setting up project: $PROJECT_NAME"

# Create new Vite project
echo "Creating new Vite project with React and TypeScript..."
npm create vite@latest "$PROJECT_NAME" -- --template react-ts
cd "$PROJECT_NAME"

# Install base dependencies
echo "Installing base dependencies..."
npm install

# Install Tailwind CSS and its peer dependencies
echo "Installing Tailwind CSS and related packages..."
npm install -D tailwindcss postcss autoprefixer

# Install development dependencies
echo "Installing development dependencies..."
npm install -D @types/node @typescript-eslint/eslint-plugin @typescript-eslint/parser \
    eslint eslint-plugin-react eslint-plugin-react-hooks prettier eslint-config-prettier \
    eslint-plugin-prettier vite-tsconfig-paths clsx @heroicons/react dayjs vitest \
    @testing-library/react @testing-library/jest-dom

# Initialize Tailwind CSS
echo "Initializing Tailwind CSS..."
npx tailwindcss init -p

# Create Tailwind configuration
cat > tailwind.config.js << 'EOL'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

# Update src/index.css with Tailwind directives
cat > src/index.css << 'EOL'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Create tsconfig.json
cat > tsconfig.json << 'EOL'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOL

# Create tsconfig.node.json
cat > tsconfig.node.json << 'EOL'
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
EOL

# Create vite.config.ts
cat > vite.config.ts << 'EOL'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tsconfigPaths from 'vite-tsconfig-paths'
import path from 'path'

export default defineConfig({
  plugins: [react(), tsconfigPaths()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3000,
  },
  build: {
    sourcemap: true,
  }
})
EOL

# Create ESLint configuration
cat > .eslintrc.json << 'EOL'
{
  "env": {
    "browser": true,
    "es2021": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react-hooks/recommended",
    "plugin:prettier/recommended"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaFeatures": {
      "jsx": true
    },
    "ecmaVersion": 12,
    "sourceType": "module"
  },
  "plugins": ["react", "@typescript-eslint", "prettier"],
  "rules": {
    "react/react-in-jsx-scope": "off",
    "prettier/prettier": "error",
    "@typescript-eslint/explicit-module-boundary-types": "off"
  },
  "settings": {
    "react": {
      "version": "detect"
    }
  }
}
EOL

# Create Prettier configuration
cat > .prettierrc << 'EOL'
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false
}
EOL

# Create VSCode debugging configuration directory
mkdir -p .vscode

# Create launch.json for debugging
cat > .vscode/launch.json << 'EOL'
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "chrome",
      "request": "launch",
      "name": "Launch Chrome against localhost",
      "url": "http://localhost:3000",
      "webRoot": "${workspaceFolder}/src",
      "sourceMaps": true,
      "sourceMapPathOverrides": {
        "webpack:///./src/*": "${webRoot}/*"
      }
    },
    {
      "type": "node",
      "request": "launch",
      "name": "Debug Current Test File",
      "autoAttachChildProcesses": true,
      "skipFiles": ["<node_internals>/**", "**/node_modules/**"],
      "program": "${workspaceRoot}/node_modules/vitest/vitest.mjs",
      "args": ["run", "${relativeFile}"],
      "smartStep": true,
      "console": "integratedTerminal"
    }
  ]
}
EOL

# Create VSCode settings
cat > .vscode/settings.json << 'EOL'
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "typescript.tsdk": "node_modules/typescript/lib",
  "typescript.enablePromptUseWorkspaceTsdk": true
}
EOL

# Create project structure
echo "Creating project structure..."
mkdir -p src/{components,layouts,pages,hooks,utils,types,stores}
touch src/{components,layouts,pages,hooks,utils,types,stores}/index.ts

# Update package.json scripts
npm pkg set scripts.dev="vite" \
    scripts.build="tsc && vite build" \
    scripts.preview="vite preview" \
    scripts.lint="eslint src --ext ts,tsx --report-unused-disable-directives --max-warnings 0" \
    scripts.format="prettier --write \"src/**/*.{ts,tsx}\"" \
    scripts."type-check"="tsc --noEmit" \
    scripts.test="vitest" \
    scripts."test:ui"="vitest --ui" \
    scripts.coverage="vitest run --coverage"

# Create .gitignore
cat > .gitignore << 'EOL'
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

# Dependencies
node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
!.vscode/settings.json
!.vscode/launch.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Environment files
.env
.env.*
EOL

# Initialize git repository
git init
git add .
git commit -m "Initial commit: Project setup with Vite, React, TypeScript, and Tailwind CSS"

echo "✨ Setup completed successfully! ✨"
echo "To start development:"
echo "1. cd $PROJECT_NAME"
echo "2. Install recommended VSCode extensions:"
echo "   - ESLint"
echo "   - Prettier"
echo "   - Chrome Debugger"
echo "   - TypeScript and JavaScript Language Features"
echo "3. npm run dev"
echo ""
echo "Happy coding! 🚀"