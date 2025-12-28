import React, { useEffect, useState } from 'react';
import { MessageSquarePlus, MessageSquare, History, UserCog, Ghost } from 'lucide-react';
import type { Session, Profile } from '../types';
import { supabase } from '../lib/supabase';
import { clsx } from 'clsx';
import { Link } from 'react-router-dom';

interface SidebarProps {
    currentSessionId: string | null;
    onSelectSession: (id: string) => void;
    onNewChat: () => void;
    profile: Profile;
    refreshKey?: number; // Ajout pour forcer le refresh
}

export const Sidebar: React.FC<SidebarProps> = ({ currentSessionId, onSelectSession, onNewChat, profile, refreshKey = 0 }) => {
    const [sessions, setSessions] = useState<Session[]>([]);

    useEffect(() => {
        // Refresh on session change OR when refreshKey changes
        fetchSessions();
    }, [currentSessionId, refreshKey]); // Ajout de refreshKey

    const fetchSessions = async () => {
        if (!supabase) return;

        console.log("Fetching sessions for user:", profile.id);

        const { data, error } = await supabase
            .from('sessions')
            .select('*')
            .eq('user_id', profile.id) // <--- PRIVATE SESSIONS
            .order('created_at', { ascending: false })
            .limit(20);

        if (error) {
            console.error("Error fetching sessions:", error);
        }

        if (data) {
            console.log("Sessions loaded:", data.length);
            setSessions(data);
        }
    };

    return (
        <aside className="w-64 bg-slate-50 border-r border-slate-200 h-[calc(100vh-4rem)] flex flex-col">
            <div className="p-4">
                <button
                    onClick={onNewChat}
                    className="w-full flex items-center justify-center gap-2 bg-emerald-600 hover:bg-emerald-700 text-white py-3 rounded-2xl font-semibold shadow-lg shadow-emerald-200 transition-all active:scale-95"
                >
                    <MessageSquarePlus size={20} />
                    Nouveau Chat
                </button>
            </div>

            <div className="flex-1 overflow-y-auto px-3 py-2 space-y-1 custom-scrollbar">
                <div className="px-3 py-2 text-xs font-bold text-slate-400 uppercase tracking-wider flex items-center gap-2">
                    <History size={12} />
                    Historique
                </div>

                {sessions.length === 0 ? (
                    <div className="text-center py-10 text-slate-400">
                        <Ghost className="mx-auto mb-2 opacity-50" size={32} />
                        <p className="text-sm">Aucune conversation</p>
                    </div>
                ) : (
                    sessions.map((session) => (
                        <button
                            key={session.id}
                            onClick={() => onSelectSession(session.id)}
                            className={clsx(
                                "w-full text-left px-4 py-3 rounded-xl text-sm transition-all flex items-start gap-3",
                                currentSessionId === session.id
                                    ? "bg-white shadow-sm border border-emerald-100 text-emerald-800 font-medium"
                                    : "text-slate-600 hover:bg-slate-100/50 hover:text-slate-900"
                            )}
                        >
                            <MessageSquare size={16} className={currentSessionId === session.id ? "text-emerald-500 mt-0.5" : "text-slate-400 mt-0.5"} />
                            <span className="truncate">{session.title || "Nouvelle conversation"}</span>
                        </button>
                    ))
                )}
            </div>

            {profile.role === 'admin' && (
                <div className="p-4 border-t border-slate-200 bg-emerald-50/50">
                    <Link to="/admin" className="flex items-center gap-3 px-4 py-3 text-emerald-800 font-bold bg-white border border-emerald-200 rounded-xl hover:shadow-md transition-all text-sm">
                        <UserCog size={18} />
                        Panel Admin
                    </Link>
                </div>
            )}
        </aside>
    );
};
