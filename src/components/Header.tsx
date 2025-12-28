import React from 'react';
import { Bot, UserCircle } from 'lucide-react';
import type { Profile } from '../types';

interface HeaderProps {
    profile: Profile | null;
    onLogout: () => void;
}

export const Header: React.FC<HeaderProps> = ({ profile, onLogout }) => {
    return (
        <header className="h-16 bg-white/80 backdrop-blur-md border-b border-emerald-100 flex items-center justify-between px-6 sticky top-0 z-10 shadow-sm">
            <div className="flex items-center gap-3">
                <img src="/yafi.png" alt="YAFI Logo" className="w-10 h-10 rounded-xl shadow-lg shadow-emerald-200 object-cover" />
                <div>
                    <h1 className="font-bold text-slate-800 text-lg leading-tight">PFE Chatbot</h1>
                    <p className="text-xs text-emerald-600 font-medium">EST Safi Edition</p>
                </div>
            </div>

            <div className="flex items-center gap-4">
                <button className="hidden md:flex items-center gap-2 px-4 py-2 bg-emerald-50 text-emerald-700 rounded-full text-sm font-semibold hover:bg-emerald-100 transition-colors">
                    <Bot size={18} />
                    <span>Assistant Actif</span>
                </button>

                {profile && (
                    <div className="flex items-center gap-3 pl-4 border-l border-slate-200">
                        <div className="text-right hidden sm:block">
                            <p className="text-sm font-bold text-slate-700">{profile.name}</p>
                            <p className="text-xs text-slate-500 uppercase">{profile.role}</p>
                        </div>
                        <button onClick={onLogout} className="p-1 hover:bg-slate-100 rounded-full transition-colors" title="Déconnexion">
                            <UserCircle size={32} className="text-slate-400" />
                        </button>
                    </div>
                )}
            </div>
        </header>
    );
};
