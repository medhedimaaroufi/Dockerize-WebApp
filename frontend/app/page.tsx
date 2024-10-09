"use client";

import { useEffect, useState } from "react";
import { fetchFromServer } from "./action";

interface DataResponse {
    message: string; // Adjust this based on your backend response structure
}

export default function Home() {
    const [text, setText] = useState<string>("");
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetchFromServer(); // Use await here
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const data: DataResponse = await response.json();
                setText(data.message); // Assuming the backend responds with a 'message'
            } catch (error: any) {
                console.error("Error fetching data:", error);
                setError("Failed to fetch data");
            }
        };

        fetchData();
    }, []);

    return (
        <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
            <main className="flex flex-col gap-8 row-start-2 items-center sm:items-start">
                <h1 className="text-5xl font-[family-name:var(--font-geist-sans)]">
                    {error ? `Error: ${error}` : `Hello Frontend! ${text}`}
                </h1>
            </main>
        </div>
    );
}
