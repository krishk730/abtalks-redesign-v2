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
