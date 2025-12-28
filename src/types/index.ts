export interface Profile {
    id: string;
    name: string;
    email: string;
    role: 'user' | 'admin';
    joinedAt: string;
}

export interface Session {
    id: string;
    user_id: string;
    title: string;
    created_at: string;
}

export interface Message {
    id: string;
    session_id: string;
    role: 'user' | 'assistant' | 'system';
    content: string;
    created_at: string;
}
