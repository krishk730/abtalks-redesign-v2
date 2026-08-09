# ABTalks — AI Usage Log

## Project Overview

ABTalks is a 60-day build-in-public challenge platform designed for Indian college students.

The project helps students build consistently, maintain a public streak, and submit two proofs for each challenge day:
- GitHub proof
- LinkedIn proof

The application was developed with an AI-assisted workflow and then tested and refined through build/deployment checks.

---

## AI Tools Used

### 1. ChatGPT

ChatGPT was used for:
- Project planning and architecture
- Feature planning
- UX/UI improvement ideas
- Technical guidance
- Debugging and troubleshooting
- Deployment guidance
- Reviewing build errors
- Preparing documentation and submission requirements

### 2. Claude

Claude was used as the primary coding assistant for generating and iterating on the ABTalks application.

It was used for:
- Creating the Next.js project structure
- Generating the initial application architecture
- Creating design tokens and global styles
- Creating reusable UI components
- Creating the challenge state layer
- Creating mock data for the 60-day challenge
- Implementing React Context and localStorage persistence
- Implementing dashboard and challenge-day functionality
- Preparing setup scripts
- Reviewing project consistency
- Helping troubleshoot implementation issues

---

## Key Prompts / Instructions Used

### Prompt 1 — Project Architecture

Build ABTalks as a polished mobile-first 60-day build-in-public challenge application.

Use:
- Next.js App Router
- Tailwind CSS
- React Context + useReducer
- localStorage persistence
- Lucide icons
- Framer Motion where useful

Routes should include:

- `/`
- `/dashboard`
- `/day/[dayId]`

The application should have a premium, warm visual style and should avoid looking like a generic AI-generated dashboard.

---

### Prompt 2 — Design System

Create a premium mobile-first design system for ABTalks.

Use:
- Warm orange accent
- Warm neutral background
- Near-black typography
- Editorial display typography
- Clean UI typography
- Rounded cards
- Soft borders
- Minimum 44px touch targets
- Responsive design around a 390px mobile viewport

The design should feel polished, modern and suitable for a hackathon submission.

---

### Prompt 3 — Challenge State Layer

Implement the ABTalks challenge state layer using React Context and useReducer.

The state should support:

- 60 challenge days
- Current streak
- Longest streak
- Completed days
- Missed days
- GitHub proof
- LinkedIn proof
- Day completion
- Achievements
- localStorage persistence

The application should derive statistics from the day data instead of storing duplicate statistics.

---

### Prompt 4 — Proof Submission

Implement a proof submission flow for every challenge day.

A student should be able to submit:

1. GitHub proof URL
2. LinkedIn proof URL

The day should show:

`0/2 → 1/2 → 2/2`

The Complete Day action should only become available after both proofs are submitted.

Use lightweight URL validation instead of real GitHub or LinkedIn APIs because the project uses mocked client-side data.

---

### Prompt 5 — Edge Cases

Implement and support these challenge states:

- First day / zero streak
- Missed day
- Streak reset
- Empty achievements/profile state
- Completed days
- Upcoming days

These states should be derived from the challenge data and reflected consistently throughout the application.

---

### Prompt 6 — Build and Debugging

After implementation, run a production build and fix any build errors.

The project was tested through GitHub Actions and Vercel deployment.

Build issues were debugged by inspecting deployment logs and correcting project configuration, root directory and missing source files where necessary.

---

## Development Workflow

The project followed this general workflow:

1. Plan the product and feature architecture
2. Generate the Next.js application structure
3. Implement the design system
4. Implement reusable components
5. Implement challenge state and mock data
6. Implement dashboard and challenge-day functionality
7. Add proof submission flow
8. Test the application locally/live
9. Run production build checks
10. Deploy using Vercel
11. Test the final live application

---

## Important Technical Decisions

### No Backend

The hackathon version intentionally uses mocked client-side data.

No external database or authentication system is required for the current scope.

### localStorage

Challenge progress is persisted using browser localStorage so that:

- proof submissions survive refreshes
- streak/progress state feels persistent
- the demo works without a backend

### Dynamic Challenge Days

The challenge-day route uses:

`/day/[dayId]`

This allows any day from the 60-day challenge to be represented instead of hardcoding only Day 12.

---

## AI Assistance Disclosure

AI tools were used as development assistants for planning, code generation, UI implementation, debugging, documentation and development guidance.

The generated code was reviewed, integrated into the project, tested through builds/deployment, and checked using the final live application.

AI assistance was treated as a development tool rather than as a replacement for testing and review.
