import React, { useState, useEffect } from 'react';
import { BrowserRouter, Routes, Route, Navigate, Link } from 'react-router-dom';
import { Header } from './components/Header';
import { Sidebar } from './components/Sidebar';
import { ChatArea } from './components/ChatArea';
import { AdminPanel } from './components/AdminPanel';
import { LandingPage } from './components/LandingPage';
import { apiService } from './lib/api';
import { supabase } from './lib/supabase';
import type { Message, Profile } from './types';
import { ArrowRight, User, Lock, GraduationCap, ArrowLeft, Loader2, AlertCircle, Mail } from 'lucide-react';
import { clsx } from 'clsx';

function App() {
  const [profile, setProfile] = useState<Profile | null>(null);
  const [showLanding, setShowLanding] = useState(true);

  // 1. Initialization
  useEffect(() => {
    const savedUser = localStorage.getItem('est_safi_user_v2');
    if (savedUser) {
      const parsedUser = JSON.parse(savedUser);
      setProfile(parsedUser);
      setShowLanding(false);

      // RE-VERIFY & REFRESH DATA FROM DB (Critical for role updates)
      if (parsedUser.email) {
        supabase.from('users').select('*').eq('email', parsedUser.email).single().then(({ data, error }) => {
          if (data) {
            console.log("Profile refreshed from DB:", data);
            const updatedProfile = {
              id: data.id,
              name: data.full_name,
              email: data.email,
              role: data.role as 'user' | 'admin',
              joinedAt: data.created_at
            };
            setProfile(updatedProfile);
            localStorage.setItem('est_safi_user_v2', JSON.stringify(updatedProfile));
          } else if (error) {
            console.error("Error refreshing profile:", error);
          }
        });
      }
    }
  }, []);

  const handleAuthSuccess = (profile: Profile) => {
    localStorage.setItem('est_safi_user_v2', JSON.stringify(profile));
    setProfile(profile);
    setShowLanding(false);
  };

  const handleLogout = () => {
    localStorage.removeItem('est_safi_user_v2');
    setProfile(null);
    setShowLanding(true);
  };

  if (showLanding && !profile) {
    return <LandingPage onStart={() => setShowLanding(false)} />;
  }

  if (!profile) {
    return <LoginScreen onAuthSuccess={handleAuthSuccess} onBack={() => setShowLanding(true)} />;
  }

  return (
    <BrowserRouter>
      <div className="h-screen flex flex-col bg-slate-50 font-sans text-slate-900">
        <Header profile={profile} onLogout={handleLogout} />
        <div className="flex flex-1 overflow-hidden">
          <Routes>
            <Route path="/" element={<ChatLayout profile={profile} />} />
            <Route path="/admin" element={
              profile.role === 'admin' ? <AdminPanel /> : <Navigate to="/" />
            } />
          </Routes>
        </div>
      </div>
    </BrowserRouter>
  );
}

// =============================================
// AUTHENTICATION SCREEN (EMAIL & PASSWORD)
// =============================================
const LoginScreen = ({ onAuthSuccess, onBack }: { onAuthSuccess: (p: Profile) => void, onBack: () => void }) => {
  const [isRegistering, setIsRegistering] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [fullName, setFullName] = useState('');

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      if (isRegistering) {
        // --- INSCRIPTION ---
        // 1. Vérifier si l'email existe
        const { data: existing, error: checkError } = await supabase.from('users').select('id').eq('email', email).single();

        // Ignore "Row not found" error (PGRST116) as it means we can proceed
        if (checkError && checkError.code !== 'PGRST116') {
          console.error("Check Error:", checkError);
          throw new Error("Erreur lors de la vérification de l'email.");
        }

        if (existing) throw new Error("Cet email possède déjà un compte.");

        // 2. Créer l'utilisateur (Par défaut role = 'user')
        const { data, error: insertError } = await supabase.from('users').insert({
          full_name: fullName,
          email: email,
          password: password, // Note: En prod, il faut hasher ce mot de passe !
          role: 'user'
        }).select().single();

        if (insertError) {
          console.error("Insert Error:", insertError);
          throw new Error("Erreur lors de la création du compte: " + insertError.message);
        }

        // 3. Connexion automatique
        if (data) {
          onAuthSuccess({
            id: data.id,
            name: data.full_name,
            email: data.email,
            role: data.role as 'user' | 'admin',
            joinedAt: data.created_at
          });
        }

      } else {
        // --- CONNEXION ---
        console.log("Attempting login for:", email);

        // Vérifier Email + Password
        const { data, error } = await supabase
          .from('users')
          .select('*')
          .eq('email', email)
          .eq('password', password)
          .single();

        if (error) {
          console.error("Login Error:", error);
          if (error.code === 'PGRST116') {
            throw new Error("Email ou mot de passe incorrect.");
          }
          throw new Error("Erreur de connexion base de données.");
        }

        if (!data) {
          throw new Error("Compte introuvable.");
        }

        console.log("Login successful:", data.id);

        // LE ROLE VIENT DE LA BDD (data.role)
        onAuthSuccess({
          id: data.id,
          name: data.full_name,
          email: data.email,
          role: data.role as 'user' | 'admin',
          joinedAt: data.created_at
        });
      }
    } catch (err: any) {
      console.error(err);
      setError(err.message || "Une erreur technique est survenue.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col items-center justify-center p-4">
      <button onClick={onBack} className="absolute top-8 left-8 flex items-center gap-2 text-slate-400 hover:text-slate-600 transition-colors">
        <ArrowLeft size={20} /> Retour
      </button>

      <div className="bg-white p-8 rounded-3xl shadow-xl w-full max-w-md animate-fade-in border border-slate-100">
        <div className="text-center mb-8">
          <div className="w-16 h-16 bg-emerald-600 rounded-2xl flex items-center justify-center text-white mb-4 mx-auto shadow-lg shadow-emerald-200">
            <GraduationCap size={40} />
          </div>
          <h1 className="text-2xl font-bold text-slate-800">{isRegistering ? 'Nouveau Compte' : 'Bon retour !'}</h1>
          <p className="text-slate-500">Connectez-vous pour accéder au Chatbot PFE.</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">

          {isRegistering && (
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Nom Complet</label>
              <div className="relative">
                <User className="absolute left-3 top-3.5 text-slate-400" size={18} />
                <input
                  type="text"
                  value={fullName}
                  onChange={(e) => setFullName(e.target.value)}
                  placeholder="Ex: Ahmed Etudiant"
                  className="w-full pl-10 pr-4 py-3 rounded-xl border border-slate-200 focus:ring-2 focus:ring-emerald-500 outline-none"
                  required
                />
              </div>
            </div>
          )}

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Email</label>
            <div className="relative">
              <Mail className="absolute left-3 top-3.5 text-slate-400" size={18} />
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="nom@exemple.com"
                className="w-full pl-10 pr-4 py-3 rounded-xl border border-slate-200 focus:ring-2 focus:ring-emerald-500 outline-none"
                required
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Mot de passe</label>
            <div className="relative">
              <Lock className="absolute left-3 top-3.5 text-slate-400" size={18} />
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="••••••••"
                className="w-full pl-10 pr-4 py-3 rounded-xl border border-slate-200 focus:ring-2 focus:ring-emerald-500 outline-none"
                required
              />
            </div>
          </div>

          {error && (
            <div className="p-3 bg-red-50 text-red-600 text-sm rounded-lg flex items-center gap-2 animate-shake">
              <AlertCircle size={16} />
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full btn-primary flex items-center justify-center gap-2 group disabled:opacity-70 disabled:cursor-not-allowed"
          >
            {loading ? <Loader2 className="animate-spin" /> : (
              <>
                {isRegistering ? "S'inscrire" : "Se connecter"}
                <ArrowRight size={20} className="group-hover:translate-x-1 transition-transform" />
              </>
            )}
          </button>
        </form>

        <button
          onClick={() => { setIsRegistering(!isRegistering); setError(null); }}
          className="w-full mt-6 text-sm text-center text-slate-500 hover:text-emerald-600 font-medium transition-colors"
        >
          {isRegistering ? "J'ai déjà un compte ? Me connecter" : "Pas encore de compte ? M'inscrire"}
        </button>
      </div>
    </div>
  );
};

// =============================================
// CHAT LAYOUT LOGIC
// =============================================

const ChatLayout = ({ profile }: { profile: Profile }) => {
  const [currentSessionId, setCurrentSessionId] = useState<string | null>(null);
  const [messages, setMessages] = useState<Message[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [sidebarRefreshKey, setSidebarRefreshKey] = useState(0); // Force sidebar refresh

  useEffect(() => {
    if (!currentSessionId) {
      setMessages([]);
      return;
    }
    const loadMessages = async () => {
      const { data } = await supabase
        .from('messages')
        .select('*')
        .eq('session_id', currentSessionId)
        .order('created_at', { ascending: true });
      if (data) setMessages(data as Message[]);
    };
    loadMessages();
  }, [currentSessionId]);

  const handleNewChat = () => {
    setCurrentSessionId(null);
    setMessages([]);
  };

  const handleSendMessage = async (content: string) => {
    const tempUserMsg: Message = {
      id: crypto.randomUUID(),
      session_id: currentSessionId || 'temp',
      role: 'user',
      content,
      created_at: new Date().toISOString(),
    };

    setMessages(prev => [...prev, tempUserMsg]);
    setIsLoading(true);

    try {
      let sessionId = currentSessionId;
      // CREATE SESSION IF NEEDED
      if (!sessionId) {
        const { data: sessionData } = await supabase
          .from('sessions')
          .insert({
            title: content.slice(0, 30) + '...',
            user_id: profile.id // Use REAL UUID now
          })
          .select()
          .single();

        if (sessionData) {
          sessionId = sessionData.id;
          setCurrentSessionId(sessionId);
          setSidebarRefreshKey(prev => prev + 1); // Force sidebar to refresh
          console.log('New session created:', sessionId);
        } else {
          sessionId = crypto.randomUUID();
          setCurrentSessionId(sessionId);
        }
      }

      // SAVE USER MSG (with error handling)
      if (sessionId) {
        const { error: saveError } = await supabase.from('messages').insert({
          session_id: sessionId,
          role: 'user',
          content
        });
        if (saveError) {
          console.error('Error saving user message:', saveError);
        } else {
          console.log('User message saved to session:', sessionId);
        }
      }

      // CALL AI (Python + Prolog)
      const responseText = await apiService.sendMessage(messages, content, profile.id);

      const aiMsg: Message = {
        id: crypto.randomUUID(),
        session_id: sessionId!,
        role: 'assistant',
        content: responseText,
        created_at: new Date().toISOString(),
      };

      setMessages(prev => [...prev, aiMsg]);

      // SAVE AI MSG (with error handling)
      if (sessionId) {
        const { error: aiSaveError } = await supabase.from('messages').insert({
          session_id: sessionId,
          role: 'assistant',
          content: responseText
        });
        if (aiSaveError) {
          console.error('Error saving AI message:', aiSaveError);
        } else {
          console.log('AI message saved to session:', sessionId);
        }
      }

    } catch (error: any) {
      console.error(error);
      let errorText = "Désolé, je ne peux pas répondre pour le moment.";

      if (error.message?.includes('429') || error.status === 429) {
        errorText = "⚠️ Limite de quota atteinte. Le modèle est surchargé, veuillez patienter une minute avant de réessayer.";
      }

      const errorMsg: Message = {
        id: crypto.randomUUID(),
        session_id: currentSessionId || 'temp',
        role: 'system',
        content: errorText,
        created_at: new Date().toISOString()
      };
      setMessages(prev => [...prev, errorMsg]);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      <Sidebar
        currentSessionId={currentSessionId}
        onSelectSession={setCurrentSessionId}
        onNewChat={handleNewChat}
        profile={profile}
        refreshKey={sidebarRefreshKey}
      />
      <ChatArea
        messages={messages}
        isLoading={isLoading}
        onSendMessage={handleSendMessage}
        userName={profile.name}
      />
    </>
  );
};

export default App;
