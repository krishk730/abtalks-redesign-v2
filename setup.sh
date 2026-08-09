#!/usr/bin/env bash
set -euo pipefail

echo "Setting up ABTalks (Step 2: challenge state layer) in ./abtalks-v2 ..."

ROOT="abtalks-v2"
mkdir -p "$ROOT"
cd "$ROOT"

# Create every directory the file list below needs, before writing any files into them.
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

export interface ChallengeState {
  student: StudentProfile;
  days: ChallengeDay[];
  achievements: Achievement[];
  isHydrated: boolean;
}

/** Slice of state that is safe/useful to persist to localStorage. */
export interface PersistedChallengeState {
  days: ChallengeDay[];
  achievements: Achievement[];
}

/** Derived, computed-on-read stats — never stored directly. */
export interface ChallengeStats {
  daysCompleted: number;
  currentStreak: number;
  longestStreak: number;
  completionPercent: number;
  isFirstDay: boolean;
  isEmptyProfile: boolean;
  hasMissedDays: boolean;
  missedDayNumbers: number[];
}
ABTALKS_EOF

cat > "lib/mock-data.ts" << 'ABTALKS_EOF'
import type { Achievement, ChallengeDay, DayProofs, DayStatus, StudentProfile } from "@/lib/types";

/**
 * All timestamps below are fixed ISO strings (never `new Date()` at module
 * scope) so the mock data is 100% deterministic between server and client
 * renders — no hydration mismatches sneak in from the data layer itself.
 */

export const MOCK_STUDENT: StudentProfile = {
  id: "stu_arjun_mehta",
  name: "Arjun Mehta",
  track: "Web Development",
  collegeYear: "3rd Year, B.Tech CSE",
  city: "Pune",
  totalDays: 60,
  currentDay: 12,
  rank: 214,
  totalParticipants: 3120,
  percentile: 93,
  joinedAt: "2026-06-20T09:00:00.000Z",
};

function proof(submitted: boolean, url?: string, submittedAt?: string): DayProofs["github"] {
  return submitted ? { submitted: true, url, submittedAt } : { submitted: false };
}

function isoDay(day: number, hour = 22, minute = 15): string {
  // Day 1 anchored to the student's join date; each day is one calendar day later.
  const base = new Date("2026-06-20T00:00:00.000Z");
  base.setUTCDate(base.getUTCDate() + (day - 1));
  base.setUTCHours(hour, minute, 0, 0);
  return base.toISOString();
}

interface AuthoredDay {
  dayNumber: number;
  title: string;
  brief: string;
  objectives: string[];
  status: DayStatus;
  githubSubmitted?: boolean;
  linkedinSubmitted?: boolean;
}

// Days 1–12 are hand-authored so the early history reads like a real track.
// Day 7 is intentionally missed (0/2 proofs) so the missed-day state has
// real data to render in a later step. Day 12 is "today" — in progress,
// 0/2 proofs — so the full proof-submission journey has something to do.
const AUTHORED_DAYS: AuthoredDay[] = [
  {
    dayNumber: 1,
    title: "Set up your dev environment",
    brief: "Install your toolchain and ship a hello-world page so today's proof is trivial but real.",
    objectives: [
      "Install Node.js, Git, and a code editor",
      "Create a new project and push the first commit",
      "Deploy a one-line hello-world page",
    ],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 2,
    title: "Build a static landing page",
    brief: "Structure a single page with semantic HTML and your first pass of CSS.",
    objectives: ["Write semantic HTML sections", "Style with plain CSS", "Commit and push"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 3,
    title: "Add a responsive layout with Flexbox",
    brief: "Make yesterday's page usable on a phone screen, not just a laptop.",
    objectives: ["Convert the layout to Flexbox", "Test at 390px width", "Fix any overflow"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 4,
    title: "Create a reusable Button component",
    brief: "Extract a Button component with variants so future days can reuse it.",
    objectives: ["Define primary/secondary variants", "Handle disabled state", "Use it in two places"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 5,
    title: "Fetch and render data from an API",
    brief: "Call a public API and render the response as a list.",
    objectives: ["Fetch from a public API", "Handle loading and error states", "Render a list view"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 6,
    title: "Add form validation",
    brief: "Build a form that validates input before it can be submitted.",
    objectives: ["Build a controlled form", "Add inline validation messages", "Block invalid submits"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 7,
    title: "Build a to-do list with local storage",
    brief: "Persist a simple to-do list across page reloads using localStorage.",
    objectives: ["Build add/remove/complete actions", "Persist state to localStorage", "Reload and verify it sticks"],
    status: "missed",
  },
  {
    dayNumber: 8,
    title: "Style with CSS Grid",
    brief: "Rebuild one section of your project as a CSS Grid layout.",
    objectives: ["Convert a section to CSS Grid", "Handle a responsive column collapse", "Compare to the Flexbox version"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 9,
    title: "Add client-side routing",
    brief: "Wire up multiple pages/views with client-side routing.",
    objectives: ["Add at least two routes", "Add a nav between them", "Handle a 404 view"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 10,
    title: "Connect to a mock backend",
    brief: "Wire a form or list to a mock/local API instead of hardcoded data.",
    objectives: ["Stand up a mock API layer", "Read data from it", "Write data back to it"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 11,
    title: "Write your first unit tests",
    brief: "Add a test file and cover at least one real function or component.",
    objectives: ["Install a test runner", "Write 2–3 unit tests", "Get them passing in CI or locally"],
    status: "completed",
    githubSubmitted: true,
    linkedinSubmitted: true,
  },
  {
    dayNumber: 12,
    title: "Build a searchable data table",
    brief: "Render a dataset as a table with working search and sort.",
    objectives: [
      "Render tabular data from an array",
      "Add a search input that filters rows",
      "Add sortable column headers",
    ],
    status: "today",
  },
];

// Days 13–60 are generated so the full 60-day arc exists, without hand
// authoring every entry. Titles rotate through a realistic topic pool.
const GENERATED_TOPICS = [
  "Add dark mode with a theme toggle",
  "Build a modal/dialog component",
  "Add pagination to a list view",
  "Debounce a search input",
  "Build a drag-and-drop sortable list",
  "Add authentication-style form UI (no real backend)",
  "Optimize images and lazy-load below the fold",
  "Build a toast/notification system",
  "Add keyboard navigation to a menu",
  "Write an integration test for a user flow",
  "Refactor a component for reusability",
  "Add a loading skeleton to a slow view",
  "Build a multi-step form wizard",
  "Add basic analytics event tracking",
  "Improve accessibility on an existing page",
];

function generatedDay(dayNumber: number): AuthoredDay {
  const topic = GENERATED_TOPICS[dayNumber % GENERATED_TOPICS.length];
  return {
    dayNumber,
    title: topic,
    brief: `Day ${dayNumber} of the track: ${topic.toLowerCase()}.`,
    objectives: [
      "Read today's brief and plan your approach",
      "Build and commit the feature",
      "Submit your GitHub and LinkedIn proof",
    ],
    status: "upcoming",
  };
}

function toChallengeDay(day: AuthoredDay): ChallengeDay {
  const github = proof(
    Boolean(day.githubSubmitted),
    day.githubSubmitted ? `https://github.com/arjunmehta/abtalks-day-${day.dayNumber}` : undefined,
    day.githubSubmitted ? isoDay(day.dayNumber, 21, 40) : undefined
  );
  const linkedin = proof(
    Boolean(day.linkedinSubmitted),
    day.linkedinSubmitted ? `https://www.linkedin.com/posts/arjunmehta_abtalks-day${day.dayNumber}` : undefined,
    day.linkedinSubmitted ? isoDay(day.dayNumber, 22, 5) : undefined
  );

  return {
    dayNumber: day.dayNumber,
    title: day.title,
    brief: day.brief,
    objectives: day.objectives,
    status: day.status,
    proofs: { github, linkedin },
    completedAt: day.status === "completed" ? isoDay(day.dayNumber, 22, 10) : undefined,
  };
}

export function buildMockDays(): ChallengeDay[] {
  const authored = AUTHORED_DAYS.map(toChallengeDay);
  const generated: ChallengeDay[] = [];
  for (let n = 13; n <= 60; n += 1) {
    generated.push(toChallengeDay(generatedDay(n)));
  }
  return [...authored, ...generated];
}

export const MOCK_ACHIEVEMENTS: Achievement[] = [
  {
    id: "first-commit",
    label: "First Commit",
    description: "Submitted your first day of proof.",
    icon: "git-commit-horizontal",
    unlocked: true,
    unlockedAt: isoDay(1, 22, 20),
  },
  {
    id: "three-day-streak",
    label: "3-Day Streak",
    description: "Completed three days in a row.",
    icon: "flame",
    unlocked: true,
    unlockedAt: isoDay(3, 22, 20),
  },
  {
    id: "ten-days-strong",
    label: "10 Days Strong",
    description: "Completed 10 total days on the track.",
    icon: "trophy",
    unlocked: true,
    unlockedAt: isoDay(11, 22, 20),
  },
  {
    id: "comeback-kid",
    label: "Comeback Kid",
    description: "Bounced back with a new streak after a missed day.",
    icon: "rotate-ccw",
    unlocked: true,
    unlockedAt: isoDay(8, 22, 20),
  },
  {
    id: "seven-day-streak",
    label: "7-Day Streak",
    description: "Complete seven days in a row without a miss.",
    icon: "zap",
    unlocked: false,
  },
  {
    id: "halfway-there",
    label: "Halfway There",
    description: "Complete 30 of the 60 days.",
    icon: "target",
    unlocked: false,
  },
  {
    id: "sixty-day-finisher",
    label: "60-Day Finisher",
    description: "Complete the full 60-day challenge.",
    icon: "medal",
    unlocked: false,
  },
];
ABTALKS_EOF

cat > "lib/challenge-context.tsx" << 'ABTALKS_EOF'
"use client";

import * as React from "react";
import { MOCK_ACHIEVEMENTS, MOCK_STUDENT, buildMockDays } from "@/lib/mock-data";
import type {
  Achievement,
  ChallengeDay,
  ChallengeState,
  ChallengeStats,
  PersistedChallengeState,
  ProofKind,
} from "@/lib/types";

const STORAGE_KEY = "abtalks:challenge:v1";

// ---------------------------------------------------------------------------
// Initial state — identical on server and client. Never read localStorage
// here; doing so would make the very first render diverge between the
// server-rendered HTML and the client's first pass, which is what causes
// React hydration mismatches. localStorage is only consulted after mount,
// inside a useEffect (see ChallengeProvider below).
// ---------------------------------------------------------------------------

function getInitialState(): ChallengeState {
  return {
    student: MOCK_STUDENT,
    days: buildMockDays(),
    achievements: MOCK_ACHIEVEMENTS,
    isHydrated: false,
  };
}

// ---------------------------------------------------------------------------
// Reducer
// ---------------------------------------------------------------------------

type Action =
  | { type: "HYDRATE"; payload: Partial<PersistedChallengeState> }
  | { type: "SUBMIT_PROOF"; dayNumber: number; kind: ProofKind; url: string }
  | { type: "COMPLETE_DAY"; dayNumber: number }
  | { type: "RESET_PROGRESS" };

function withUpdatedDay(
  days: ChallengeDay[],
  dayNumber: number,
  updater: (day: ChallengeDay) => ChallengeDay
): ChallengeDay[] {
  return days.map((day) => (day.dayNumber === dayNumber ? updater(day) : day));
}

function reducer(state: ChallengeState, action: Action): ChallengeState {
  switch (action.type) {
    case "HYDRATE": {
      // Light shape validation: only trust persisted data if it matches the
      // length of the mock dataset. Anything else (corrupted, stale-shape,
      // or from a future version of the app) falls back to mock defaults
      // instead of crashing the app.
      const days =
        action.payload.days && action.payload.days.length === state.days.length
          ? action.payload.days
          : state.days;
      const achievements =
        action.payload.achievements && action.payload.achievements.length === state.achievements.length
          ? action.payload.achievements
          : state.achievements;

      return { ...state, days, achievements, isHydrated: true };
    }

    case "SUBMIT_PROOF": {
      const trimmedUrl = action.url.trim();
      if (!trimmedUrl) return state;

      const days = withUpdatedDay(state.days, action.dayNumber, (day) => ({
        ...day,
        proofs: {
          ...day.proofs,
          [action.kind]: {
            submitted: true,
            url: trimmedUrl,
            submittedAt: new Date().toISOString(),
          },
        },
      }));

      return { ...state, days };
    }

    case "COMPLETE_DAY": {
      const target = state.days.find((day) => day.dayNumber === action.dayNumber);
      const bothProofsSubmitted = target?.proofs.github.submitted && target?.proofs.linkedin.submitted;
      if (!target || !bothProofsSubmitted || target.status === "completed") return state;

      const days = withUpdatedDay(state.days, action.dayNumber, (day) => ({
        ...day,
        status: "completed",
        completedAt: new Date().toISOString(),
      }));

      return { ...state, days };
    }

    case "RESET_PROGRESS": {
      // Useful for demoing the first-day / 0-streak / empty-profile states
      // in later steps without needing a second mock profile.
      return {
        ...state,
        days: buildMockDays().map((day) => ({
          ...day,
          status: day.dayNumber === 1 ? "today" : "upcoming",
          proofs: {
            github: { submitted: false },
            linkedin: { submitted: false },
          },
          completedAt: undefined,
        })),
        achievements: state.achievements.map((achievement) => ({
          ...achievement,
          unlocked: false,
          unlockedAt: undefined,
        })),
      };
    }

    default:
      return state;
  }
}

// ---------------------------------------------------------------------------
// Derived stats — always computed from `days`, never stored, so they can
// never drift out of sync with the actual per-day record.
// ---------------------------------------------------------------------------

function computeStats(state: ChallengeState): ChallengeStats {
  const { days, student, achievements } = state;

  const daysCompleted = days.filter((day) => day.status === "completed").length;

  let currentStreak = 0;
  for (let dayNumber = student.currentDay - 1; dayNumber >= 1; dayNumber -= 1) {
    const day = days[dayNumber - 1];
    if (day && day.status === "completed") {
      currentStreak += 1;
    } else {
      break;
    }
  }

  let longestStreak = 0;
  let running = 0;
  for (const day of days) {
    if (day.status === "completed") {
      running += 1;
      longestStreak = Math.max(longestStreak, running);
    } else {
      running = 0;
    }
  }
  longestStreak = Math.max(longestStreak, currentStreak);

  const missedDayNumbers = days.filter((day) => day.status === "missed").map((day) => day.dayNumber);
  const completionPercent = Math.round((daysCompleted / student.totalDays) * 100);
  const isFirstDay = daysCompleted === 0 && currentStreak === 0 && missedDayNumbers.length === 0;
  const isEmptyProfile = daysCompleted === 0 && achievements.every((a) => !a.unlocked);

  return {
    daysCompleted,
    currentStreak,
    longestStreak,
    completionPercent,
    isFirstDay,
    isEmptyProfile,
    hasMissedDays: missedDayNumbers.length > 0,
    missedDayNumbers,
  };
}

// ---------------------------------------------------------------------------
// Context
// ---------------------------------------------------------------------------

interface ChallengeContextValue {
  state: ChallengeState;
  stats: ChallengeStats;
  getDay: (dayNumber: number) => ChallengeDay | undefined;
  submitProof: (dayNumber: number, kind: ProofKind, url: string) => void;
  completeDay: (dayNumber: number) => void;
  resetProgress: () => void;
}

const ChallengeContext = React.createContext<ChallengeContextValue | null>(null);

export function ChallengeProvider({ children }: { children: React.ReactNode }) {
  const [state, dispatch] = React.useReducer(reducer, undefined, getInitialState);

  // Hydrate from localStorage exactly once, after mount (client-only).
  // Wrapped in try/catch so private-browsing / disabled-storage / malformed
  // JSON never crashes the app — it just falls back to the mock defaults.
  React.useEffect(() => {
    try {
      const raw = window.localStorage.getItem(STORAGE_KEY);
      const payload: Partial<PersistedChallengeState> = raw ? JSON.parse(raw) : {};
      dispatch({ type: "HYDRATE", payload });
    } catch {
      dispatch({ type: "HYDRATE", payload: {} });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Persist to localStorage after every change, but only once hydration has
  // happened — otherwise the very first (pre-hydration) render would
  // overwrite real stored progress with fresh mock data.
  React.useEffect(() => {
    if (!state.isHydrated) return;
    try {
      const toPersist: PersistedChallengeState = {
        days: state.days,
        achievements: state.achievements,
      };
      window.localStorage.setItem(STORAGE_KEY, JSON.stringify(toPersist));
    } catch {
      // Storage full or unavailable — the app keeps working in-memory.
    }
  }, [state.days, state.achievements, state.isHydrated]);

  const getDay = React.useCallback(
    (dayNumber: number) => state.days.find((day) => day.dayNumber === dayNumber),
    [state.days]
  );

  const submitProof = React.useCallback((dayNumber: number, kind: ProofKind, url: string) => {
    dispatch({ type: "SUBMIT_PROOF", dayNumber, kind, url });
  }, []);

  const completeDay = React.useCallback((dayNumber: number) => {
    dispatch({ type: "COMPLETE_DAY", dayNumber });
  }, []);

  const resetProgress = React.useCallback(() => {
    dispatch({ type: "RESET_PROGRESS" });
  }, []);

  const stats = React.useMemo(() => computeStats(state), [state]);

  const value = React.useMemo<ChallengeContextValue>(
    () => ({ state, stats, getDay, submitProof, completeDay, resetProgress }),
    [state, stats, getDay, submitProof, completeDay, resetProgress]
  );

  return <ChallengeContext.Provider value={value}>{children}</ChallengeContext.Provider>;
}

export function useChallenge(): ChallengeContextValue {
  const ctx = React.useContext(ChallengeContext);
  if (!ctx) {
    throw new Error("useChallenge must be used within a ChallengeProvider");
  }
  return ctx;
}

export type { Achievement, ChallengeDay };
ABTALKS_EOF

# --- Verify every expected file was actually created before declaring success ---
echo ""
echo "Verifying generated files ..."
MISSING=0
if [ ! -f "package.json" ]; then
  echo "MISSING: package.json" >&2
  MISSING=1
fi
if [ ! -f "tsconfig.json" ]; then
  echo "MISSING: tsconfig.json" >&2
  MISSING=1
fi
if [ ! -f "next.config.mjs" ]; then
  echo "MISSING: next.config.mjs" >&2
  MISSING=1
fi
if [ ! -f "tailwind.config.ts" ]; then
  echo "MISSING: tailwind.config.ts" >&2
  MISSING=1
fi
if [ ! -f "postcss.config.mjs" ]; then
  echo "MISSING: postcss.config.mjs" >&2
  MISSING=1
fi
if [ ! -f ".eslintrc.json" ]; then
  echo "MISSING: .eslintrc.json" >&2
  MISSING=1
fi
if [ ! -f ".gitignore" ]; then
  echo "MISSING: .gitignore" >&2
  MISSING=1
fi
if [ ! -f "next-env.d.ts" ]; then
  echo "MISSING: next-env.d.ts" >&2
  MISSING=1
fi
if [ ! -f "app/layout.tsx" ]; then
  echo "MISSING: app/layout.tsx" >&2
  MISSING=1
fi
if [ ! -f "app/globals.css" ]; then
  echo "MISSING: app/globals.css" >&2
  MISSING=1
fi
if [ ! -f "app/page.tsx" ]; then
  echo "MISSING: app/page.tsx" >&2
  MISSING=1
fi
if [ ! -f "app/dashboard/page.tsx" ]; then
  echo "MISSING: app/dashboard/page.tsx" >&2
  MISSING=1
fi
if [ ! -f "app/day/[dayId]/page.tsx" ]; then
  echo "MISSING: app/day/[dayId]/page.tsx" >&2
  MISSING=1
fi
if [ ! -f "components/layout/app-shell.tsx" ]; then
  echo "MISSING: components/layout/app-shell.tsx" >&2
  MISSING=1
fi
if [ ! -f "components/layout/header.tsx" ]; then
  echo "MISSING: components/layout/header.tsx" >&2
  MISSING=1
fi
if [ ! -f "components/layout/bottom-nav.tsx" ]; then
  echo "MISSING: components/layout/bottom-nav.tsx" >&2
  MISSING=1
fi
if [ ! -f "components/layout/container.tsx" ]; then
  echo "MISSING: components/layout/container.tsx" >&2
  MISSING=1
fi
if [ ! -f "components/ui/button.tsx" ]; then
  echo "MISSING: components/ui/button.tsx" >&2
  MISSING=1
fi
if [ ! -f "components/ui/card.tsx" ]; then
  echo "MISSING: components/ui/card.tsx" >&2
  MISSING=1
fi
if [ ! -f "lib/utils.ts" ]; then
  echo "MISSING: lib/utils.ts" >&2
  MISSING=1
fi
if [ ! -f "lib/types.ts" ]; then
  echo "MISSING: lib/types.ts" >&2
  MISSING=1
fi
if [ ! -f "lib/mock-data.ts" ]; then
  echo "MISSING: lib/mock-data.ts" >&2
  MISSING=1
fi
if [ ! -f "lib/challenge-context.tsx" ]; then
  echo "MISSING: lib/challenge-context.tsx" >&2
  MISSING=1
fi

if [ "$MISSING" -eq 1 ]; then
  echo "" >&2
  echo "setup.sh FAILED: one or more expected files were not created (see MISSING lines above)." >&2
  exit 1
fi

echo "All expected files verified present."
echo "ABTalks Step 2 setup complete."

