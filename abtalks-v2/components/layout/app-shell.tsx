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
