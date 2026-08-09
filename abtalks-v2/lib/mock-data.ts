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
