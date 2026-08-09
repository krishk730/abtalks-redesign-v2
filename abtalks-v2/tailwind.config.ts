import type { Config } from "tailwindcss";

const config: Config = {
  content: ["./app/**/*.{ts,tsx}", "./components/**/*.{ts,tsx}", "./lib/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        bg: "rgb(var(--color-bg) / <alpha-value>)",
        surface: "rgb(var(--color-surface) / <alpha-value>)",
        ink: "rgb(var(--color-ink) / <alpha-value>)",
        muted: "rgb(var(--color-muted) / <alpha-value>)",
        border: "rgb(var(--color-border) / <alpha-value>)",
        positive: "rgb(var(--color-positive) / <alpha-value>)",
        accent: {
          DEFAULT: "rgb(var(--color-accent) / <alpha-value>)",
          strong: "rgb(var(--color-accent-strong) / <alpha-value>)",
          soft: "rgb(var(--color-accent-soft) / <alpha-value>)",
        },
      },
      fontFamily: {
        display: ["var(--font-display)", "Georgia", "serif"],
        sans: ["var(--font-sans)", "ui-sans-serif", "system-ui", "sans-serif"],
      },
      fontSize: {
        "display-lg": ["2.75rem", { lineHeight: "1.05", letterSpacing: "-0.02em" }],
        display: ["2.25rem", { lineHeight: "1.08", letterSpacing: "-0.015em" }],
        "heading-lg": ["1.5rem", { lineHeight: "1.22" }],
        heading: ["1.25rem", { lineHeight: "1.3" }],
        "body-lg": ["1.0625rem", { lineHeight: "1.55" }],
        body: ["0.9375rem", { lineHeight: "1.55" }],
        caption: ["0.8125rem", { lineHeight: "1.4" }],
      },
      borderRadius: {
        card: "20px",
        "card-lg": "24px",
        pill: "999px",
      },
      boxShadow: {
        soft: "0 1px 2px rgba(26,24,21,0.04), 0 8px 24px -12px rgba(26,24,21,0.12)",
        button: "0 4px 14px -4px rgba(245,122,61,0.4)",
      },
      maxWidth: {
        app: "1120px",
      },
      screens: {
        xs: "390px",
      },
    },
  },
  plugins: [],
};

export default config;
