import React, { useRef, useEffect } from 'react';
import type { Message } from '../types';
import { Loader2, Send, Mic, MicOff } from 'lucide-react';
import { clsx } from 'clsx';
import Markdown from 'react-markdown';

interface ChatAreaProps {
    messages: Message[];
    isLoading: boolean;
    onSendMessage: (msg: string) => void;
    userName: string;
}

export const ChatArea: React.FC<ChatAreaProps> = ({ messages, isLoading, onSendMessage, userName }) => {
    const [input, setInput] = React.useState('');
    const [isListening, setIsListening] = React.useState(false);
    const scrollRef = useRef<HTMLDivElement>(null);

    const startListening = () => {
        if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
            const SpeechRecognition = (window as any).webkitSpeechRecognition || (window as any).SpeechRecognition;
            const recognition = new SpeechRecognition();
            recognition.continuous = false;
            recognition.lang = 'fr-FR';
            recognition.interimResults = false;

            recognition.onstart = () => setIsListening(true);
            recognition.onend = () => setIsListening(false);
            recognition.onresult = (event: any) => {
                const transcript = event.results[0][0].transcript;
                setInput(prev => prev + (prev ? ' ' : '') + transcript);
            };
            recognition.onerror = () => setIsListening(false);

            recognition.start();
        } else {
            alert("Votre navigateur ne supporte pas la reconnaissance vocale.");
        }
    };

    useEffect(() => {
        if (scrollRef.current) {
            scrollRef.current.scrollIntoView({ behavior: 'smooth' });
        }
    }, [messages, isLoading]);

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        if (!input.trim() || isLoading) return;
        onSendMessage(input);
        setInput('');
    };

    const suggestions = [
        "Idées de sujets PFE ?",
        "Comment structurer mon rapport ?",
        "Quelles technos pour le backend ?",
        "Aide-moi à corriger mon code"
    ];

    return (
        <main className="flex-1 flex flex-col bg-emerald-50/30 relative overflow-hidden">
            {/* Messages Area */}
            <div className="flex-1 overflow-y-auto p-4 sm:p-6 space-y-6">
                {messages.length === 0 ? (
                    <div className="h-full flex flex-col items-center justify-center text-center opacity-0 animate-fade-in" style={{ opacity: 1 }}>
                        <div className="w-24 h-24 mb-6 animate-bounce-slow">
                            <img src="/yafi.png" alt="YAFI Logo" className="w-full h-full object-contain drop-shadow-lg" />
                        </div>
                        <h2 className="text-2xl font-bold text-slate-800 mb-2">Bonjour, {userName} !</h2>
                        <p className="text-slate-500 max-w-md mb-8">Je suis votre assistant académique PFE. Posez-moi une question ou choisissez une suggestion ci-dessous.</p>

                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 w-full max-w-2xl">
                            {suggestions.map((s) => (
                                <button
                                    key={s}
                                    onClick={() => onSendMessage(s)}
                                    className="p-4 bg-white border border-emerald-100 rounded-2xl text-slate-600 text-sm hover:border-emerald-300 hover:shadow-md transition-all text-left"
                                >
                                    {s}
                                </button>
                            ))}
                        </div>
                    </div>
                ) : (
                    messages.map((msg) => (
                        <div
                            key={msg.id}
                            className={clsx(
                                "flex gap-4 max-w-3xl mx-auto animate-fade-in",
                                msg.role === 'user' ? "flex-row-reverse" : "flex-row"
                            )}
                        >
                            <div className={clsx(
                                "w-8 h-8 rounded-full flex items-center justify-center shrink-0",
                                msg.role === 'user' ? "bg-slate-200 text-slate-600" : "bg-emerald-600 text-white"
                            )}>
                                {msg.role === 'user' ? "U" : "IA"}
                            </div>

                            <div className={clsx(
                                "p-4 sm:p-5 rounded-2xl shadow-sm leading-relaxed text-sm sm:text-base",
                                msg.role === 'user'
                                    ? "bg-white text-slate-800 rounded-tr-none border border-slate-100"
                                    : "bg-white text-slate-800 rounded-tl-none border border-emerald-100 bg-gradient-to-br from-white to-emerald-50/50"
                            )}>
                                <Markdown
                                    components={{
                                        ul: ({ node, ...props }) => <ul {...props} className="list-disc pl-4 mb-2" />,
                                        ol: ({ node, ...props }) => <ol {...props} className="list-decimal pl-4 mb-2" />,
                                        p: ({ node, ...props }) => <p {...props} className="mb-2 last:mb-0" />,
                                        strong: ({ node, ...props }) => <strong {...props} className="font-bold text-emerald-900" />,
                                    }}
                                >
                                    {msg.content}
                                </Markdown>
                            </div>
                        </div>
                    ))
                )}

                {/* Helper for loading state */}
                {isLoading && (
                    <div className="flex gap-4 max-w-3xl mx-auto animate-fade-in">
                        <div className="w-8 h-8 rounded-full bg-emerald-600 text-white flex items-center justify-center shrink-0">
                            IA
                        </div>
                        <div className="bg-white px-4 py-3 rounded-2xl rounded-tl-none border border-emerald-100 shadow-sm flex items-center gap-2">
                            <Loader2 size={16} className="animate-spin text-emerald-600" />
                            <span className="text-slate-400 text-sm">L'IA est en train de réfléchir...</span>
                        </div>
                    </div>
                )}
                <div ref={scrollRef} />
            </div>

            {/* Input Area */}
            <div className="p-4 sm:p-6 bg-white border-t border-emerald-100">
                <form onSubmit={handleSubmit} className="max-w-3xl mx-auto relative flex items-center">
                    <input
                        type="text"
                        value={input}
                        onChange={(e) => setInput(e.target.value)}
                        placeholder="Posez votre question à propos du PFE..."
                        className="w-full pl-6 pr-24 py-4 bg-slate-50 border border-slate-200 rounded-full focus:outline-none focus:ring-2 focus:ring-emerald-500/50 focus:border-emerald-500 transition-all text-slate-700 shadow-inner"
                        disabled={isLoading}
                    />

                    <button
                        type="button"
                        onClick={startListening}
                        className={clsx(
                            "absolute right-14 p-2 rounded-full transition-all",
                            isListening ? "bg-red-100 text-red-500 animate-pulse" : "text-slate-400 hover:text-emerald-600 hover:bg-emerald-50"
                        )}
                        title="Dicter vocalement"
                    >
                        {isListening ? <MicOff size={20} /> : <Mic size={20} />}
                    </button>

                    <button
                        type="submit"
                        disabled={!input.trim() || isLoading}
                        className="absolute right-2 p-2 bg-emerald-600 text-white rounded-full hover:bg-emerald-700 disabled:opacity-50 disabled:hover:bg-emerald-600 transition-all shadow-md"
                    >
                        <Send size={20} className={isLoading ? "opacity-0" : "ml-0.5"} />
                        {isLoading && <span className="absolute inset-0 flex items-center justify-center"><Loader2 size={20} className="animate-spin" /></span>}
                    </button>
                </form>
                <p className="text-center text-xs text-slate-400 mt-2">
                    IA générative peut faire des erreurs. Vérifiez les informations importantes.
                </p>
            </div>
        </main>
    );
};
