import Link from "next/link";

export default function Page() {
    return (
        <div className="flex flex-col items-center justify-center min-h-screen py-2">
            <h1>Test Page</h1>

            <Link href="/">Go back</Link>
        </div>
    );
}