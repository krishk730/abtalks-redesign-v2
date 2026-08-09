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
