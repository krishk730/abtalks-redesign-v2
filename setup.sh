#!/usr/bin/env bash
set -euo pipefail

echo "Setting up ABTalks (Step 3: dashboard + day UI) in ./abtalks-v2 ..."

ROOT="abtalks-v2"
mkdir -p "$ROOT"
cd "$ROOT"

# Create every directory the file list below needs, before writing any files into them.
mkdir -p "app"
mkdir -p "app/dashboard"
mkdir -p "app/day/[dayId]"
mkdir -p "components/dashboard"
mkdir -p "components/day"
mkdir -p "components/layout"
mkdir -p "components/shared"
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
        negative: "rgb(var(--color-negative) / <alpha-value>)",
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
  --color-positive: 63 125 88; /* #3F7D58 — proof-complete / success states */
  --color-negative: 178 66 53; /* #B24235 — warm, muted error red for validation states */
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
"use client";

import { RotateCcw } from "lucide-react";
import { Container } from "@/components/layout/container";
import { StreakHero } from "@/components/dashboard/streak-hero";
import { MissedDayBanner } from "@/components/dashboard/missed-day-banner";
import { TodayTaskCard } from "@/components/dashboard/today-task-card";
import { MomentumCard } from "@/components/dashboard/momentum-card";
import { ProgressOverview } from "@/components/dashboard/progress-overview";
import { StandingCard } from "@/components/dashboard/standing-card";
import { AchievementsSection } from "@/components/dashboard/achievements-section";
import { useChallenge } from "@/lib/challenge-context";

export default function DashboardPage() {
  const { state, stats, getDay, resetProgress } = useChallenge();
  const { student, achievements } = state;

  const todayDay = getDay(student.currentDay);

  return (
    <Container className="py-6">
      <div className="flex items-center justify-between">
        <div>
          <p className="text-caption text-muted">Welcome back</p>
          <h1 className="font-display text-heading-lg text-ink">{student.name}</h1>
          <p className="mt-0.5 text-caption text-muted">
            {student.track} · {student.collegeYear}
          </p>
        </div>
      </div>

      <div className="mt-5 flex flex-col gap-4">
        <StreakHero
          currentStreak={stats.currentStreak}
          longestStreak={stats.longestStreak}
          isFirstDay={stats.isFirstDay}
        />

        {stats.hasMissedDays && (
          <MissedDayBanner
            missedDayNumbers={stats.missedDayNumbers}
            currentStreak={stats.currentStreak}
            longestStreak={stats.longestStreak}
          />
        )}

        {todayDay && (
          <>
            <TodayTaskCard day={todayDay} />
            <MomentumCard day={todayDay} isFirstDay={stats.isFirstDay} />
          </>
        )}

        <ProgressOverview
          daysCompleted={stats.daysCompleted}
          totalDays={student.totalDays}
          completionPercent={stats.completionPercent}
          currentStreak={stats.currentStreak}
          longestStreak={stats.longestStreak}
        />

        <StandingCard
          rank={student.rank}
          totalParticipants={student.totalParticipants}
          percentile={student.percentile}
        />

        <AchievementsSection achievements={achievements} isEmptyProfile={stats.isEmptyProfile} />

        <button
          type="button"
          onClick={resetProgress}
          className="mx-auto mt-2 inline-flex items-center gap-1.5 text-caption text-muted underline decoration-border underline-offset-4 hover:text-ink"
        >
          <RotateCcw size={12} strokeWidth={2} />
          Reset to a fresh Day 1 (demo)
        </button>
      </div>
    </Container>
  );
}
ABTALKS_EOF

cat > "app/day/[dayId]/page.tsx" << 'ABTALKS_EOF'
"use client";

import { Container } from "@/components/layout/container";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ProofHealthBadge } from "@/components/shared/proof-health-badge";
import { JourneyStepper } from "@/components/day/journey-stepper";
import { ProofForm } from "@/components/day/proof-form";
import { CompleteDayButton } from "@/components/day/complete-day-button";
import { CompletionPanel } from "@/components/day/completion-panel";
import { useChallenge } from "@/lib/challenge-context";
import { countSubmittedProofs } from "@/lib/utils";
import type { ProofKind } from "@/lib/types";

export default function ChallengeDayPage({ params }: { params: { dayId: string } }) {
  const { getDay, stats, submitProof, completeDay } = useChallenge();

  const dayNumber = Number(params.dayId);
  const day = Number.isFinite(dayNumber) ? getDay(dayNumber) : undefined;

  if (!day) {
    return (
      <Container className="py-10 text-center">
        <p className="eyebrow">Day {params.dayId}</p>
        <h1 className="mt-3 font-display text-heading-lg text-ink">This day isn&rsquo;t on the track</h1>
        <p className="mt-2 text-body text-muted">Head back to your dashboard to find today&rsquo;s challenge.</p>
        <Button href="/dashboard" className="mt-6">
          Back to dashboard
        </Button>
      </Container>
    );
  }

  const proofsCompleted = countSubmittedProofs(day.proofs);
  const isCompleted = day.status === "completed";
  const isMissed = day.status === "missed";

  function handleSubmit(kind: ProofKind) {
    return (url: string) => submitProof(day!.dayNumber, kind, url);
  }

  return (
    <Container className="py-6">
      <div className="flex items-center justify-between">
        <p className="eyebrow">Day {day.dayNumber} of 60</p>
        <Badge variant={isCompleted ? "positive" : isMissed ? "negative" : "accent"}>
          {isCompleted ? "Completed" : isMissed ? "Missed" : "Today"}
        </Badge>
      </div>

      <h1 className="mt-2 font-display text-display text-ink">{day.title}</h1>

      <div className="mt-6">
        <JourneyStepper
          hasAnyProof={proofsCompleted > 0}
          githubDone={day.proofs.github.submitted}
          linkedinDone={day.proofs.linkedin.submitted}
          isCompleted={isCompleted}
        />
      </div>

      <Card className="mt-6">
        <p className="eyebrow">What to build</p>
        <p className="mt-2 text-body text-ink">{day.brief}</p>

        <p className="mt-4 text-caption font-semibold uppercase tracking-wide text-muted">
          Acceptance criteria
        </p>
        <ul className="mt-2 flex flex-col gap-2">
          {day.objectives.map((objective) => (
            <li key={objective} className="flex items-start gap-2 text-body text-ink">
              <span className="mt-2 h-1.5 w-1.5 flex-none rounded-full bg-accent" />
              {objective}
            </li>
          ))}
        </ul>
      </Card>

      {isCompleted && <div className="mt-6"><CompletionPanel dayNumber={day.dayNumber} currentStreak={stats.currentStreak} /></div>}

      <div className="mt-6 flex items-center justify-between">
        <p className="eyebrow">Proof health</p>
        <ProofHealthBadge completed={proofsCompleted} />
      </div>

      <div className="mt-3 flex flex-col gap-4">
        <ProofForm kind="github" proof={day.proofs.github} disabled={isCompleted} onSubmit={handleSubmit("github")} />
        <ProofForm kind="linkedin" proof={day.proofs.linkedin} disabled={isCompleted} onSubmit={handleSubmit("linkedin")} />
      </div>

      {!isCompleted && (
        <div className="mt-6">
          <CompleteDayButton proofsCompleted={proofsCompleted} onComplete={() => completeDay(day.dayNumber)} />
        </div>
      )}
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
                  "text-[0.6875rem] font-mediu
