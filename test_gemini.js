import { GoogleGenerativeAI } from '@google/generative-ai';

// Hardcoded key for the test script to avoid env parsing issues in simple node run
const API_KEY = 'AIzaSyD-aSMQxVD8lxP_hXMLGvf9DWcq4-4Yboc';

const genAI = new GoogleGenerativeAI(API_KEY);

async function listModels() {
    try {
        console.log("Fetching available models...");
        // For listing models, we don't need a specific model instance, just the generic client usually?
        // Actually the SDK exposes generic usage or we can try a basic getModel.
        // But the best way to debug '404 model not found' is to try to list them if the SDK supports it, or just try a simple generation.

        // The node SDK doesn't always expose listModels directly on the main class in older versions, 
        // but in 0.24.1 it might. Let's try a simple generation with 'gemini-1.5-flash' explicitly to see the detailed error in Node.

        const model = genAI.getGenerativeModel({ model: 'gemini-1.5-flash' });
        const result = await model.generateContent('Hello');
        console.log("Success! gemini-1.5-flash is working.");
        console.log("Response:", result.response.text());

    } catch (error) {
        console.error("Error creating chat:", error.message);
        if (error.response) {
            console.error("Full Error:", JSON.stringify(error.response, null, 2));
        }
    }
}

listModels();
