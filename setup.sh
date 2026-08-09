#!/usr/bin/env bash
set -euo pipefail

echo "Setting up ABTalks (Step 2: challenge state layer) in ./abtalks-v2 ..."

ROOT="abtalks-v2"
mkdir -p "$ROOT"
cd "$ROOT"

mkdir -p "app"
mkdir -p "app/dashboard"
mkdir -p "app/day/[dayId]"
mkdir -p "components/layout"
mkdir -p "components/ui"
mkdir -p "lib"

cat > "package.json" << 'ABTALKS_EOF'
{
  "name": "abtalks",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "14.2.5",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "lucide-react": "^0.400.0",
    "framer-motion": "^11.2.10",
    "clsx": "^2.1.1",
    "tailwind-merge": "^2.3.0"
  },
  "devDependencies": {
    "typescript": "^5.5.3",
    "@types/node": "^20.14.9",
    "@types/react": "^18.3.3",
    "@types/react-dom": "^18.3.0",
    "tailwindcss": "^3.4.4",
    "postcss": "^8.4.39",
    "autoprefixer": "^10.4.19",
    "eslint": "^8.57.0",
    "eslint-config-next": "14.2.5"
  }
}
ABTALKS_EOF

cat > "tsconfig.json" << 'ABTALKS_EOF'
{
  "compilerOptions": {
    "target": "ES2017",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
ABTALKS_EOF

cat > "next.config.mjs" << 'ABTALKS_EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
};

export default nextConfig;
ABTALKS_EOF

cat > "tailwind.config.ts" << 'ABTALKS_EOF'
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
ABTALKS_EOF

cat > "postcss.config.mjs" << 'ABTALKS_EOF'
/** @type {import('postcss-load-config').Config} */
const config = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};

export default config;
ABTALKS_EOF

cat > ".eslintrc.json" << 'ABTALKS_EOF'
{
  "extends": "next/core-web-vitals"
}
ABTALKS_EOF

cat > ".gitignore" << 'ABTALKS_EOF'
# dependencies
node_modules

# next.js
.next
out

# production
build

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# local env files
.env*.local

# typescript
*.tsbuildinfo
ABTALKS_EOF

cat > "next-env.d.ts" << 'ABTALKS_EOF'
/// <reference types="next" />
/// <reference types="next/image-types/global" />

// NOTE: This file should not be edited
// see https://nextjs.org/docs/app/building-your-application/configuring/typescript for more information.
ABTALKS_EOF

cat > "app/layout.tsx" << 'ABTALKS_EOF'
import type { Metadata, Viewport } from "next";
import { Fraunces, Manrope } from "next/font/google";
import { AppShell } from "@/components/layout/app-shell";
import { ChallengeProvider } from "@/lib/challenge-context";
import "./globals.css";

const fraunces = Fraunces({
  subsets: ["latin"],
  variable: "--font-display",
  weight: ["400", "500", "600", "700"],
  style: ["normal", "italic"],
  display: "swap",
});

const manrope = Manrope({
  subsets: ["latin"],
  variable: "--font-sans",
  weight: ["400", "500", "600", "700", "800"],
  display: "swap",
});

export const metadata: Metadata = {
  title: "ABTalks — 60-Day Coding Challenge",
  description:
    "Build in public for 60 days. Pick a track, ship daily, and prove it with a GitHub commit and a LinkedIn post.",
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 1,
  themeColor: "#FAF8F5",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`${fraunces.variable} ${manrope.variable}`}>
      <body>
        <ChallengeProvider>
          <AppShell>{children}</AppShell>
        </ChallengeProvider>
      </body>
    </html>
  );
}
ABTALKS_EOF

cat > "app/globals.css" << 'ABTALKS_EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

/*
  Design tokens.
  Colors are stored as space-separated RGB channels so Tailwind can apply
  opacity modifiers (e.g. bg-bg/90, text-ink/60) on top of them.
*/
:root {
  --color-bg: 250 248 245; /* #FAF8F5 — warm neutral background */
  --color-surface: 255 255 255; /* #FFFFFF — card surface */
  --color-ink: 26 24 21; /* #1A1815 — primary text */
  --color-muted: 122 114 104; /* #7A7268 — secondary text */
  --color-accent: 245 122 61; /* #F57A3D — primary orange accent */
  --color-accent-strong: 221 101 41; /* #DD6529 — accent hover/active */
  --color-accent-soft: 252 232 219; /* #FCE8DB — accent tint background */
  --color-border: 231 225 214; /* #E7E1D6 — soft 1px borders */
  --color-positive: 63 125 88; /* #3F7D58 — reserved for proof-complete states */
}

* {
  box-sizing: border-box;
}

html {
  -webkit-text-size-adjust: 100%;
}

html,
body {
  background-color: rgb(var(--color-bg));
  color: rgb(var(--color-ink));
  overflow-x: hidden;
}

body {
  font-family: var(--font-sans), ui-sans-serif, system-ui, -apple-system, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-rendering: optimizeLegibility;
}

img,
svg {
  display: block;
  max-width: 100%;
}

::selection {
  background-color: rgb(var(--color-accent-soft));
  color: rgb(var(--color-ink));
}

:focus-visible {
  outline: 2px solid rgb(var(--color-accent));
  outline-offset: 2px;
  border-radius: 4px;
}

/* Display typeface utility — applied on top of Tailwind's font-display */
.font-display {
  font-family: var(--font-display), Georgia, serif;
}

/* Small uppercase label used above headings ("eyebrow" text) */
.eyebrow {
  font-family: var(--font-sans), sans-serif;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: rgb(var(--color-accent-strong));
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}

.no-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}

@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
ABTALKS_EOF

cat > "app/page.tsx" << 'ABTALKS_EOF'
import { Container } from "@/components/layout/container";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

export default function LandingPage() {
  return (
    <Container className="py-10 sm:py-16">
      <p className="eyebrow">Route · /</p>

      <h1 className="mt-3 max-w-lg font-display text-display-lg text-ink">
        Ship something,
        <br />
        every single day.
      </h1>

      <p className="mt-4 max-w-md text-body-lg text-muted">
        This is the landing page foundation for ABTalks — a 60-day build-in-public
        challenge for Indian college students. Full marketing content arrives in the
        next step.
      </p>

      <div className="mt-8 flex flex-wrap gap-3">
        <Button href="/dashboard">Start the challenge</Button>
        <Button href="/day/12" variant="secondary">
          Preview a challenge day
        </Button>
      </div>

      <Card className="mt-10 max-w-md">
        <p className="eyebrow">Foundation check</p>
        <h2 className="mt-2 font-display text-heading-lg text-ink">Design system online</h2>
        <p className="mt-2 text-body text-muted">
          Warm neutral background, near-black text, one careful orange accent, editorial
          display type, rounded 20px cards, and soft 1px borders.
        </p>
      </Card>
    </Container>
  );
}
ABTALKS_EOF

cat > "app/dashboard/page.tsx" << 'ABTALKS_EOF'
import { Container } from "@/components/layout/container";
import { Card } from "@/components/ui/card";

export default function DashboardPage() {
  return (
    <Container className="py-8">
      <p className="eyebrow">Route · /dashboard</p>
      <h1 className="mt-3 font-display text-display text-ink">Dashboard</h1>
      <p className="mt-3 max-w-md text-body text-muted">
        Streak, today&rsquo;s task, 60-day progress, standing, and achievements will live
        here. This placeholder confirms the shared header and bottom navigation.
      </p>

      <div className="mt-8 grid gap-4">
        <Card>
          <p className="eyebrow">Current streak</p>
          <p className="mt-2 font-display text-display text-ink">—</p>
          <p className="mt-1 text-caption text-muted">Coming in the next step</p>
        </Card>

        <Card>
          <p className="eyebrow">Today&rsquo;s task</p>
          <p className="mt-2 text-body text-muted">Coming in the next step.</p>
        </Card>
      </div>
    </Container>
  );
}
ABTALKS_EOF

cat > "app/day/[dayId]/page.tsx" << 'ABTALKS_EOF'
import { Container } from "@/components/layout/container";
import { Card } from "@/components/ui/card";

export default function ChallengeDayPage({ params }: { params: { dayId: string } }) {
  return (
    <Container className="py-8">
      <p className="eyebrow">Route · /day/{params.dayId}</p>
      <h1 className="mt-3 font-display text-display text-ink">Day {params.dayId}</h1>
      <p className="mt-3 max-w-md text-body text-muted">
        The task brief and the Understand → Build → GitHub Proof → LinkedIn Proof →
        Complete journey will live here.
      </p>

      <Card className="mt-8">
        <p className="eyebrow">Proof health</p>
        <p className="mt-2 text-body text-muted">0/2 proofs complete — coming in the next step.</p>
      </Card>
    </Container>
  );
}
ABTALKS_EOF

cat > "components/layout/app-shell.tsx" << 'ABTALKS_EOF'
"use client";

import * as React from "react";
import { usePathname } from "next/navigation";
import { Header } from "@/components/layout/header";
import { BottomNav } from "@/components/layout/bottom-nav";
import { cn } from "@/lib/utils";

export function AppShell({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const hasBottomNav = pathname.startsWith("/dashboard") || pathname.startsWith("/day");

  return (
    <div className="flex min-h-dvh flex-col">
      <Header />
      <main className={cn("flex-1", hasBottomNav && "pb-24")}>{children}</main>
      {hasBottomNav && <BottomNav />}
    </div>
  );
}
ABTALKS_EOF

cat > "components/layout/header.tsx" << 'ABTALKS_EOF'
"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { Container } from "@/components/layout/container";
import { Button } from "@/components/ui/button";

export function Header() {
  const pathname = usePathname();
  const isLanding = pathname === "/";

  return (
    <header className="sticky top-0 z-40 border-b border-border bg-bg/90 backdrop-blur-sm">
      <Container>
        <div className="flex h-16 items-center justify-between">
          <Link
            href="/"
            className="font-display text-[1.25rem] font-semibold tracking-tight text-ink"
          >
            ABTalks
          </Link>

          {isLanding && (
            <Button href="/dashboard" size="sm">
              Start now
            </Button>
          )}
        </div>
      </Container>
    </header>
  );
}
ABTALKS_EOF

cat > "components/layout/bottom-nav.tsx" << 'ABTALKS_EOF'
"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { LayoutGrid, CalendarCheck } from "lucide-react";
import { cn } from "@/lib/utils";

const NAV_ITEMS = [
  { href: "/dashboard", label: "Home", icon: LayoutGrid },
  { href: "/day/12", label: "Today", icon: CalendarCheck },
] as const;

export function BottomNav() {
  const pathname = usePathname();

  return (
    <nav
      className="fixed inset-x-0 bottom-0 z-40 border-t border-border bg-surface/95 backdrop-blur-sm"
      aria-label="Primary"
    >
      <div
        className="mx-auto flex max-w-app items-stretch justify-around px-2 pt-1.5"
        style={{ paddingBottom: "max(8px, env(safe-area-inset-bottom))" }}
      >
        {NAV_ITEMS.map(({ href, label, icon: Icon }) => {
          const isActive = href === "/dashboard" ? pathname === href : pathname.startsWith("/day");

          return (
            <Link
              key={href}
              href={href}
              className="flex min-w-[72px] flex-1 flex-col items-center justify-center gap-1 py-2"
              aria-current={isActive ? "page" : undefined}
            >
              <Icon
                size={22}
                strokeWidth={isActive ? 2.4 : 1.8}
                className={isActive ? "text-accent" : "text-muted"}
              />
              <span
                className={cn(
                  "text-[0.6875rem] font-medium",
                  isActive ? "text-ink" : "text-muted"
                )}
              >
                {label}
              </span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
ABTALKS_EOF

cat > "components/layout/container.tsx" << 'ABTALKS_EOF'
import * as React from "react";
import { cn } from "@/lib/utils";

export function Container({ className, children, ...rest }: React.HTMLAttributes<HTMLDivElement>) {
  return (
    <div className={cn("mx-auto w-full max-w-app px-4 xs:px-5 lg:px-8", className)} {...rest}>
      {children}
    </div>
  );
}
ABTALKS_EOF

cat > "components/ui/button.tsx" << 'ABTALKS_EOF'
import * as React from "react";
import Link from "next/link";
import { cn } from "@/lib/utils";

type ButtonVariant = "primary" | "secondary" | "ghost";
type ButtonSize = "default" | "sm";

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: ButtonVariant;
  size?: ButtonSize;
  /** If provided, renders as a Next.js Link instead of a <button>. */
  href?: string;
}

const variantStyles: Record<ButtonVariant, string> = {
  primary: "bg-accent text-white shadow-button hover:bg-accent-strong active:bg-accent-strong",
  secondary:
    "bg-transparent text-ink border border-border hover:border-ink/25 active:bg-ink/[0.03]",
  ghost: "bg-transparent text-ink hover:bg-ink/[0.04] active:bg-ink/[0.06]",
};

// default = 56px tall, sm = 44px tall — matches the 44–56px touch target spec.
const sizeStyles: Record<ButtonSize, string> = {
  default: "h-14 px-7 text-[0.9375rem]",
  sm: "h-11 px-5 text-[0.875rem]",
};

const base =
  "inline-flex items-center justify-center gap-2 rounded-pill font-sans font-semibold " +
  "transition-colors duration-150 ease-out disabled:opacity-40 disabled:pointer-events-none select-none";

export function Button({
  variant = "primary",
  size = "default",
  className,
  children,
  href,
  ...rest
}: ButtonProps) {
  const classes = cn(base, variantStyles[variant], sizeStyles[size], className);

  if (href) {
    return (
      <Link href={href} className={classes}>
        {children}
      </Link>
    );
  }

  return (
    <button className={classes} {...rest}>
      {children}
    </button>
  );
}
ABTALKS_EOF

cat > "components/ui/card.tsx" << 'ABTALKS_EOF'
import * as React from "react";
import { cn } from "@/lib/utils";

interface CardProps extends React.HTMLAttributes<HTMLDivElement> {
  padding?: "default" | "compact" | "none";
}

const paddingStyles: Record<NonNullable<CardProps["padding"]>, string> = {
  default: "p-5 xs:p-6",
  compact: "p-4",
  none: "",
};

export function Card({ className, padding = "default", children, ...rest }: CardProps) {
  return (
    <div
      className={cn(
        "rounded-card border border-border bg-surface shadow-soft",
        paddingStyles[padding],
        className
      )}
      {...rest}
    >
      {children}
    </div>
  );
}
ABTALKS_EOF

cat > "lib/utils.ts" << 'ABTALKS_EOF'
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

/**
 * Merges class names and resolves conflicting Tailwind utility classes,
 * so components can accept a `className` override safely.
 */
export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
ABTALKS_EOF

cat > "lib/types.ts" << 'ABTALKS_EOF'
// Core domain types for the ABTalks mocked challenge state layer.
// No backend / database — everything here describes the shape of
// client-side state that lives in React Context + localStorage.

export type Track = "Web Development" | "DSA" | "Machine Learning" | "Mobile Development";

/**
 * Status of an individual challenge day.
 * - upcoming: in the future, not yet reachable
 * - today:    the day currently active for the student
 * - completed: both proofs were submitted and the day was marked done
 * - missed:   the day passed without both proofs being submitted
 */
export type DayStatus = "upcoming" | "today" | "completed" | "missed";

export type ProofKind = "github" | "linkedin";

export interface ProofState {
  submitted: boolean;
  url?: string;
  submittedAt?: string; // ISO 8601
}

export interface DayProofs {
  github: ProofState;
  linkedin: ProofState;
}

export interface ChallengeDay {
  dayNumber: number;
  title: string;
  brief: string;
  objectives: string[];
  status: DayStatus;
  proofs: DayProofs;
  completedAt?: string; // ISO 8601, set when status becomes "completed"
}

export interface Achievement {
  id: string;
  label: string;
  description: string;
  /** Lucide icon name — rendered by the UI layer in a later step. */
  icon: string;
  unlocked: boolean;
  unlockedAt?: string; // ISO 8601
}

/**
 * Static-ish profile info. Fields here don't change as a direct result of
 * challenge activity — derived numbers (streak, completion %, etc.) are
 * computed from `days` instead of stored here, so they can never drift
 * out of sync with the actual day-by-day record.
 */
export interface StudentProfile {
  id: string;
  name: string;
  track: Track;
  collegeYear: string;
  city: string;
  totalDays: 60;
  currentDay: number;
  rank: number;
  totalParticipants: number;
  percentile: number;
  joinedAt: string; // ISO 8601
}

export interf
