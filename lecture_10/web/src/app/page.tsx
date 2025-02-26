"use client";
import Image from "next/image";
import Link from "next/link";
import { useState } from "react";

export default function Home() {
  const [count, setCount] = useState(0);

  const increment = () => setCount(count + 1);
  const decrement = () => setCount(count - 1);

  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2">
      <Image src="/next.svg" alt="logo" width={200} height={200} />

      <div className="flex flex-col items-center justify-center mt-4">
        <h1 className="text-2xl">Count: {count}</h1>
        
        <div className="flex mt-4">
          <button className="px-4 py-2 bg-blue-500 text-white" onClick={increment}>Increment</button>
          <button className="px-4 py-2 bg-red-500 text-white" onClick={decrement}>Decrement</button>
        </div>
      </div>

      <div className="mt-4">
        <Link href="/test">Go to test page</Link>
      </div>
    </div>
  );
}
