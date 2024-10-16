"use server";

export async function fetchFromServer() {
    const apiBaseUrl = process.env.NEXT_PUBLIC_API_URL || 'http://127.0.0.1:5000';
    return fetch(apiBaseUrl);
}
