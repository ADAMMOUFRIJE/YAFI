import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/supabase';
import { FileText, Database, Brain, Users, Save, Trash, Plus, ArrowLeft } from 'lucide-react';
import { clsx } from 'clsx';
import { Link } from 'react-router-dom';

export const AdminPanel = () => {
    const [activeTab, setActiveTab] = useState<'instructions' | 'knowledge' | 'memory' | 'members'>('instructions');

    const TabButton = ({ id, icon: Icon, label }: { id: any, icon: any, label: string }) => (
        <button
            onClick={() => setActiveTab(id)}
            className={clsx(
                "flex items-center gap-2 px-6 py-4 font-medium transition-all border-b-2",
                activeTab === id
                    ? "border-emerald-600 text-emerald-800 bg-emerald-50/50"
                    : "border-transparent text-slate-500 hover:text-slate-700 hover:bg-slate-50"
            )}
        >
            <Icon size={18} />
            {label}
        </button>
    );

    return (
        <div className="min-h-screen bg-slate-50 p-6 font-sans">
            <header className="mb-8 flex items-center justify-between">
                <div>
                    <div className="flex items-center gap-2 text-slate-400 mb-2 hover:text-emerald-600 transition-colors">
                        <ArrowLeft size={16} />
                        <Link to="/" className="text-sm font-semibold">Retour au Chat</Link>
                    </div>
                    <h1 className="text-3xl font-bold text-slate-800">Admin Center</h1>
                    <p className="text-slate-500">PFE Chatbot Configuration</p>
                </div>
            </header>

            <div className="bg-white rounded-3xl shadow-sm border border-slate-200 overflow-hidden">
                <div className="flex border-b border-slate-200 overflow-x-auto">
                    <TabButton id="instructions" icon={FileText} label="Instructions" />
                    <TabButton id="knowledge" icon={Database} label="Base Documentaire" />
                    <TabButton id="memory" icon={Brain} label="Mémoire Apprise" />
                    <TabButton id="members" icon={Users} label="Membres" />
                </div>

                <div className="p-8 min-h-[500px]">
                    {activeTab === 'instructions' && <InstructionsTab />}
                    {activeTab === 'knowledge' && <KnowledgeTab />}
                    {activeTab === 'memory' && <MemoryTab />}
                    {activeTab === 'members' && <MembersTab />}
                </div>
            </div>
        </div>
    );
};

const InstructionsTab = () => {
    // System Prompts could be stored in Knowledge Base as a special type for MVP
    const [prompt, setPrompt] = useState(`Tu es l'assistant PFE de l'EST Safi. Ton identité est "Emerald AI"...`);

    const handleSave = () => {
        alert("Prompt système sauvegardé (Simulation PFE)");
        // In real app, save to a 'settings' table.
    };

    return (
        <div className="max-w-3xl">
            <h2 className="text-xl font-bold mb-4">System Prompt Global</h2>
            <p className="text-sm text-slate-500 mb-4">Ce prompt définit la personnalité et les règles strictes de l'IA.</p>
            <textarea
                className="w-full h-64 p-4 rounded-xl border border-slate-300 focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 font-mono text-sm leading-relaxed"
                value={prompt}
                onChange={(e) => setPrompt(e.target.value)}
            />
            <button onClick={handleSave} className="mt-4 px-6 py-3 bg-emerald-600 text-white font-bold rounded-xl flex items-center gap-2 hover:bg-emerald-700 shadow-lg shadow-emerald-200 transition-all">
                <Save size={18} /> Sauvegarder
            </button>
        </div>
    )
}

const KnowledgeTab = () => {
    const [docs, setDocs] = useState<any[]>([]);
    const [newDocName, setNewDocName] = useState('');
    const [newDocContent, setNewDocContent] = useState('');

    useEffect(() => {
        const fetchDocs = async () => {
            const { data } = await supabase.from('knowledge_base').select('*');
            if (data) setDocs(data);
        };
        fetchDocs();
    }, []);

    const handleAdd = async () => {
        if (!newDocName || !newDocContent) return;
        const { data, error } = await supabase.from('knowledge_base').insert({
            name: newDocName,
            content: newDocContent,
            type: 'text/plain'
        }).select();

        if (data) {
            setDocs([...docs, data[0]]);
            setNewDocName('');
            setNewDocContent('');
        }
    };

    return (
        <div>
            <div className="flex justify-between items-center mb-6">
                <h2 className="text-xl font-bold">Base de Connaissances (RAG)</h2>
            </div>

            {/* Add New */}
            <div className="bg-slate-50 p-6 rounded-2xl border border-slate-200 mb-8">
                <h3 className="font-bold text-slate-700 mb-4">Ajouter un document texte</h3>
                <div className="space-y-3">
                    <input
                        className="w-full p-3 rounded-lg border border-slate-300"
                        placeholder="Titre du document (ex: Guide PFE 2024)"
                        value={newDocName}
                        onChange={e => setNewDocName(e.target.value)}
                    />
                    <textarea
                        className="w-full p-3 rounded-lg border border-slate-300 h-32"
                        placeholder="Contenu du document..."
                        value={newDocContent}
                        onChange={e => setNewDocContent(e.target.value)}
                    />
                    <button onClick={handleAdd} className="px-4 py-2 bg-slate-800 text-white rounded-lg text-sm font-semibold hover:bg-slate-900">
                        Publier dans la base
                    </button>
                </div>
            </div>

            {/* List */}
            <div className="grid gap-4">
                {docs.length === 0 ? (
                    <div className="text-center py-8 text-slate-400 bg-white border border-dashed border-slate-200 rounded-xl">
                        <Database size={32} className="mx-auto mb-2 opacity-50" />
                        <p>Aucun document.</p>
                    </div>
                ) : docs.map(doc => (
                    <div key={doc.id} className="p-4 bg-white border border-slate-100 rounded-xl shadow-sm flex justify-between items-center group">
                        <div className="flex items-center gap-3">
                            <div className="p-2 bg-emerald-50 text-emerald-600 rounded-lg">
                                <FileText size={20} />
                            </div>
                            <div>
                                <p className="font-bold text-slate-800">{doc.name}</p>
                                <p className="text-xs text-slate-400">Ajouté le {new Date(doc.created_at).toLocaleDateString()}</p>
                            </div>
                        </div>
                        <button className="text-slate-300 hover:text-red-500 transition-colors p-2">
                            <Trash size={18} />
                        </button>
                    </div>
                ))}
            </div>
        </div>
    )
}

const MemoryTab = () => {
    const [facts, setFacts] = useState<any[]>([]);

    useEffect(() => {
        const fetchFacts = async () => {
            const { data } = await supabase.from('learning_base').select('*').order('created_at', { ascending: false });
            if (data) setFacts(data);
        };
        fetchFacts();
    }, []);

    return (
        <div>
            <h2 className="text-xl font-bold mb-6">Mémoire Active (Facts)</h2>
            <div className="space-y-3">
                {facts.length === 0 ? <p className="text-slate-400">Aucun fait mémorisé.</p> : facts.map(f => (
                    <div key={f.id} className="flex items-center justify-between p-4 bg-white border border-slate-100 rounded-xl shadow-sm">
                        <div>
                            <p className="font-medium text-slate-800">{f.fact}</p>
                            <p className="text-xs text-slate-400">User: {f.user_id}</p>
                        </div>
                        <button className="text-red-400 hover:text-red-600 p-2"><Trash size={18} /></button>
                    </div>
                ))}
            </div>
        </div>
    )
}

const MembersTab = () => {
    const [members, setMembers] = useState<any[]>([]);
    const [selectedMember, setSelectedMember] = useState<any | null>(null);
    const [memberSessions, setMemberSessions] = useState<any[]>([]);
    const [memberMessages, setMemberMessages] = useState<any[]>([]);

    useEffect(() => {
        const fetchMembers = async () => {
            // Fetch real users from our custom table
            const { data } = await supabase
                .from('users')
                .select('*')
                .order('created_at', { ascending: false });

            if (data) setMembers(data);
        };
        fetchMembers();
    }, []);

    // Load member sessions and messages when selected
    useEffect(() => {
        if (!selectedMember) {
            setMemberSessions([]);
            setMemberMessages([]);
            return;
        }

        const loadMemberData = async () => {
            // Fetch sessions
            const { data: sessions } = await supabase
                .from('sessions')
                .select('*')
                .eq('user_id', selectedMember.id)
                .order('created_at', { ascending: false });

            if (sessions) {
                setMemberSessions(sessions);

                // Fetch all messages from all sessions
                const sessionIds = sessions.map(s => s.id);
                if (sessionIds.length > 0) {
                    const { data: messages } = await supabase
                        .from('messages')
                        .select('*')
                        .in('session_id', sessionIds)
                        .order('created_at', { ascending: true });

                    if (messages) setMemberMessages(messages);
                }
            }
        };
        loadMemberData();
    }, [selectedMember]);

    // Extract profile info from messages
    const extractProfileInfo = (messages: any[]) => {
        const userMessages = messages.filter(m => m.role === 'user').map(m => m.content.toLowerCase());
        const fullText = userMessages.join(' ');

        const info: { age?: string; bac?: string; moyenne?: string; ville?: string; objectif?: string } = {};

        // Extract age
        const ageMatch = fullText.match(/j'ai (\d+) ans|(\d+) ans|age (\d+)/);
        if (ageMatch) info.age = (ageMatch[1] || ageMatch[2] || ageMatch[3]) + ' ans';

        // Extract Bac type  
        if (fullText.includes('bac pc') || fullText.includes('pc')) info.bac = 'PC';
        else if (fullText.includes('bac sm') || fullText.includes('sm')) info.bac = 'SM';
        else if (fullText.includes('bac svt') || fullText.includes('svt')) info.bac = 'SVT';
        else if (fullText.includes('bac eco') || fullText.includes('eco')) info.bac = 'ECO';
        else if (fullText.includes('bac litt')) info.bac = 'Littéraire';

        // Extract moyenne
        const moyenneMatch = fullText.match(/moyenne (\d+\.?\d*)|(\d+\.?\d*) de moyenne|note (\d+\.?\d*)/);
        if (moyenneMatch) info.moyenne = (moyenneMatch[1] || moyenneMatch[2] || moyenneMatch[3]) + '/20';

        // Extract city
        const villes = ['casablanca', 'rabat', 'marrakech', 'fès', 'tanger', 'agadir', 'oujda', 'safi', 'kenitra'];
        for (const v of villes) {
            if (fullText.includes(v)) {
                info.ville = v.charAt(0).toUpperCase() + v.slice(1);
                break;
            }
        }

        // Extract objective
        if (fullText.includes('médecine') || fullText.includes('medecine')) info.objectif = 'Médecine';
        else if (fullText.includes('ingénieur') || fullText.includes('ingenieur') || fullText.includes('ensa')) info.objectif = 'Ingénierie';
        else if (fullText.includes('informatique') || fullText.includes('it') || fullText.includes('data')) info.objectif = 'Informatique';
        else if (fullText.includes('commerce') || fullText.includes('gestion')) info.objectif = 'Commerce/Gestion';

        return info;
    };

    const profileInfo = selectedMember ? extractProfileInfo(memberMessages) : {};

    return (
        <div>
            <h2 className="text-xl font-bold mb-6">Utilisateurs Enregistrés</h2>

            {/* Back button if member is selected */}
            {selectedMember && (
                <button
                    onClick={() => setSelectedMember(null)}
                    className="mb-4 px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-lg text-sm font-medium flex items-center gap-2"
                >
                    <ArrowLeft size={16} /> Retour à la liste
                </button>
            )}

            {/* Member detail view */}
            {selectedMember ? (
                <div className="space-y-6">
                    {/* Member header */}
                    <div className="bg-gradient-to-r from-emerald-50 to-slate-50 p-6 rounded-2xl border border-emerald-100">
                        <div className="flex items-center gap-4">
                            <div className={clsx(
                                "w-16 h-16 rounded-full flex items-center justify-center font-bold text-white text-2xl",
                                selectedMember.role === 'admin' ? "bg-emerald-600" : "bg-slate-500"
                            )}>
                                {selectedMember.full_name?.charAt(0).toUpperCase() || "?"}
                            </div>
                            <div>
                                <h3 className="text-2xl font-bold text-slate-800">{selectedMember.full_name}</h3>
                                <p className="text-slate-500">{selectedMember.email}</p>
                                <span className={clsx(
                                    "text-xs px-3 py-1 rounded-full font-medium mt-2 inline-block",
                                    selectedMember.role === 'admin' ? "bg-emerald-100 text-emerald-800" : "bg-slate-100 text-slate-600"
                                )}>
                                    {selectedMember.role === 'admin' ? 'Administrateur' : 'Utilisateur'}
                                </span>
                            </div>
                        </div>
                    </div>

                    {/* Profile info extracted from conversations */}
                    <div className="bg-white p-6 rounded-2xl border border-slate-200">
                        <h4 className="font-bold text-slate-700 mb-4 flex items-center gap-2">
                            <Brain size={18} className="text-emerald-500" />
                            Profil Extrait des Conversations
                        </h4>
                        {Object.keys(profileInfo).length > 0 ? (
                            <div className="grid grid-cols-2 gap-4">
                                {profileInfo.age && (
                                    <div className="p-3 bg-slate-50 rounded-lg">
                                        <p className="text-xs text-slate-400 uppercase">Âge</p>
                                        <p className="font-bold text-slate-800">{profileInfo.age}</p>
                                    </div>
                                )}
                                {profileInfo.bac && (
                                    <div className="p-3 bg-slate-50 rounded-lg">
                                        <p className="text-xs text-slate-400 uppercase">Type de Bac</p>
                                        <p className="font-bold text-slate-800">Bac {profileInfo.bac}</p>
                                    </div>
                                )}
                                {profileInfo.moyenne && (
                                    <div className="p-3 bg-slate-50 rounded-lg">
                                        <p className="text-xs text-slate-400 uppercase">Moyenne</p>
                                        <p className="font-bold text-slate-800">{profileInfo.moyenne}</p>
                                    </div>
                                )}
                                {profileInfo.ville && (
                                    <div className="p-3 bg-slate-50 rounded-lg">
                                        <p className="text-xs text-slate-400 uppercase">Ville</p>
                                        <p className="font-bold text-slate-800">{profileInfo.ville}</p>
                                    </div>
                                )}
                                {profileInfo.objectif && (
                                    <div className="p-3 bg-emerald-50 rounded-lg col-span-2">
                                        <p className="text-xs text-emerald-600 uppercase">Objectif</p>
                                        <p className="font-bold text-emerald-800">{profileInfo.objectif}</p>
                                    </div>
                                )}
                            </div>
                        ) : (
                            <p className="text-slate-400 italic">Aucune information personnelle détectée dans les conversations.</p>
                        )}
                    </div>

                    {/* Sessions summary */}
                    <div className="bg-white p-6 rounded-2xl border border-slate-200">
                        <h4 className="font-bold text-slate-700 mb-4">Sessions ({memberSessions.length})</h4>
                        <div className="space-y-2 max-h-64 overflow-y-auto">
                            {memberSessions.map(s => (
                                <div key={s.id} className="p-3 bg-slate-50 rounded-lg flex justify-between items-center">
                                    <p className="font-medium text-slate-700 truncate">{s.title || 'Nouvelle conversation'}</p>
                                    <p className="text-xs text-slate-400">{new Date(s.created_at).toLocaleDateString()}</p>
                                </div>
                            ))}
                            {memberSessions.length === 0 && (
                                <p className="text-slate-400 italic">Aucune session.</p>
                            )}
                        </div>
                    </div>
                </div>
            ) : (
                /* Member list */
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    {members.map((m) => (
                        <div
                            key={m.id}
                            onClick={() => setSelectedMember(m)}
                            className="p-4 bg-white border border-slate-200 rounded-xl flex items-center gap-4 hover:shadow-md hover:border-emerald-200 transition-all cursor-pointer"
                        >
                            <div className={clsx(
                                "w-12 h-12 rounded-full flex items-center justify-center font-bold text-white text-lg",
                                m.role === 'admin' ? "bg-emerald-600" : "bg-slate-400"
                            )}>
                                {m.full_name?.charAt(0).toUpperCase() || "?"}
                            </div>
                            <div className="flex-1">
                                <p className="font-bold text-slate-800">{m.full_name}</p>
                                <p className="text-sm text-slate-500">{m.email}</p>
                                <span className={clsx(
                                    "text-xs px-2 py-0.5 rounded-full font-medium mt-1 inline-block",
                                    m.role === 'admin' ? "bg-emerald-100 text-emerald-800" : "bg-slate-100 text-slate-600"
                                )}>
                                    {m.role === 'admin' ? 'Administrateur' : 'Utilisateur'}
                                </span>
                            </div>
                            <ArrowLeft size={16} className="text-slate-300 rotate-180" />
                        </div>
                    ))}
                </div>
            )}
        </div>
    )
}
