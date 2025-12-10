<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UniversityHRSystem128.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>University HR System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --bg-grey: #DBDBDB;
            --ink: #706F6F;
            --accent: #8B4557;
            --accent-soft: rgba(139, 69, 87, 0.12);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(circle at top left, #ffffff 0, #DBDBDB 40%, #c6c6c6 100%);
            min-height: 100vh;
            color: var(--ink);
            overflow-x: hidden;
        }

        /* Animated gradient halo behind hero */
        .hero-bg-orbit {
            position: fixed;
            inset: -20%;
            background:
                radial-gradient(circle at 10% 20%, rgba(139, 69, 87, 0.20), transparent 55%),
                radial-gradient(circle at 80% 0%, rgba(112, 111, 111, 0.18), transparent 60%),
                radial-gradient(circle at 50% 100%, rgba(139, 69, 87, 0.16), transparent 55%);
            opacity: 0.9;
            filter: blur(2px);
            z-index: -2;
            animation: orbitShift 22s ease-in-out infinite alternate;
        }

        @keyframes orbitShift {
            0% { transform: translate3d(0, 0, 0) scale(1); }
            50% { transform: translate3d(-25px, 18px, 0) scale(1.04); }
            100% { transform: translate3d(20px, -24px, 0) scale(1.02); }
        }

        /* Floating accent shapes */
        .floating-shape {
            position: fixed;
            border-radius: 999px;
            background: linear-gradient(135deg, rgba(139, 69, 87, 0.65), rgba(112, 111, 111, 0.6));
            opacity: 0.12;
            pointer-events: none;
            z-index: -1;
            filter: blur(1px);
        }

        .floating-shape.shape-1 {
            width: 180px;
            height: 180px;
            top: 14%;
            right: 8%;
            animation: floatY 18s ease-in-out infinite alternate;
        }

        .floating-shape.shape-2 {
            width: 260px;
            height: 260px;
            bottom: -8%;
            left: -5%;
            animation: floatX 26s ease-in-out infinite alternate;
        }

        @keyframes floatY {
            from { transform: translateY(0); }
            to { transform: translateY(-30px); }
        }

        @keyframes floatX {
            from { transform: translateX(0); }
            to { transform: translateX(40px); }
        }

        .page-shell {
            max-width: 1200px;
            margin: 0 auto;
            padding: 28px 28px 60px;
        }

        /* Top nav */
        .top-nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 32px;
        }

        .brand-mark {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .brand-logo {
            width: 36px;
            height: 36px;
            border-radius: 12px;
            background: radial-gradient(circle at 30% 20%, #ffffff, #8B4557);
            box-shadow: 0 8px 18px rgba(139, 69, 87, 0.4);
            position: relative;
            overflow: hidden;
        }

        .brand-logo::after {
            content: '';
            position: absolute;
            inset: 35%;
            border-radius: 999px;
            border: 2px solid rgba(255, 255, 255, 0.9);
            box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.6);
        }

        .brand-text-main {
            font-weight: 700;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            color: var(--ink);
            font-size: 0.92rem;
        }

        .brand-text-sub {
            font-size: 0.8rem;
            color: rgba(112, 111, 111, 0.7);
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nav-pill {
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            color: rgba(112, 111, 111, 0.8);
            padding: 6px 14px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.7);
            border: 1px solid rgba(112, 111, 111, 0.18);
            backdrop-filter: blur(8px);
        }

        .btn-ghost {
            border-radius: 999px;
            padding: 9px 20px;
            border: 1px solid rgba(112, 111, 111, 0.4);
            background: transparent;
            color: var(--ink);
            font-size: 0.85rem;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.25s ease;
        }

        .btn-ghost:hover {
            background: rgba(139, 69, 87, 0.12);
            border-color: rgba(139, 69, 87, 0.6);
        }

        .btn-primary {
            border-radius: 999px;
            padding: 10px 26px;
            border: none;
            background: linear-gradient(135deg, #8B4557, #70404f);
            color: #fff;
            font-size: 0.86rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 10px 26px rgba(112, 111, 111, 0.45);
            transform: translateY(0);
            transition: transform 0.22s ease, box-shadow 0.22s ease, filter 0.22s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 32px rgba(112, 111, 111, 0.55);
            filter: brightness(1.03);
        }

        .btn-primary span.chevron {
            font-size: 1.1rem;
            transition: transform 0.22s ease;
        }

        .btn-primary:hover span.chevron {
            transform: translateX(4px);
        }

        .btn-secondary {
            border-radius: 999px;
            padding: 9px 20px;
            border: 1px solid rgba(112, 111, 111, 0.35);
            background: rgba(255, 255, 255, 0.95);
            color: var(--ink);
            font-size: 0.82rem;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.22s ease;
        }

        .btn-secondary:hover {
            border-color: rgba(139, 69, 87, 0.65);
            color: var(--accent);
            box-shadow: 0 8px 18px rgba(112, 111, 111, 0.35);
            transform: translateY(-1px);
        }

        /* Hero layout */
        .hero {
            display: grid;
            grid-template-columns: minmax(0, 3fr) minmax(0, 2.4fr);
            gap: 40px;
            align-items: center;
            margin-bottom: 56px;
        }

        .hero-copy {
            animation: fadeIn 0.8s ease-out;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 4px 12px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(139, 69, 87, 0.35);
            font-size: 0.75rem;
            letter-spacing: 0.16em;
            text-transform: uppercase;
            color: rgba(112, 111, 111, 0.9);
            margin-bottom: 16px;
        }

        .eyebrow-dot {
            width: 9px;
            height: 9px;
            border-radius: 999px;
            background: var(--accent);
            box-shadow: 0 0 0 4px rgba(139, 69, 87, 0.25);
        }

        .hero h1 {
            font-size: 2.4rem;
            line-height: 1.18;
            color: var(--ink);
            margin-bottom: 12px;
        }

        .hero h1 span {
            color: var(--accent);
        }

        .hero-sub {
            max-width: 520px;
            font-size: 0.98rem;
            line-height: 1.6;
            color: rgba(112, 111, 111, 0.9);
            margin-bottom: 20px;
        }

        .hero-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            align-items: center;
            margin-bottom: 24px;
        }

        .hero-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .hero-stat {
            padding: 8px 14px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(112, 111, 111, 0.15);
            font-size: 0.8rem;
        }

        .hero-footnote {
            font-size: 0.8rem;
            color: rgba(112, 111, 111, 0.75);
        }

        .hero-footnote strong {
            color: var(--accent);
        }

        /* Hero visual */
        .hero-visual {
            position: relative;
            min-height: 260px;
            animation: fadeIn 0.9s ease-out 0.1s both;
        }

        .glass-panel {
            position: relative;
            padding: 22px 22px 20px;
            border-radius: 22px;
            background: radial-gradient(circle at top left, rgba(255, 255, 255, 0.96), rgba(255, 255, 255, 0.82));
            box-shadow:
                0 18px 45px rgba(112, 111, 111, 0.35),
                0 0 0 1px rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
        }

        .glass-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .glass-title {
            font-size: 0.86rem;
            font-weight: 600;
            color: var(--ink);
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 10px;
            border-radius: 999px;
            background: rgba(39, 174, 96, 0.08);
            color: #1e7b50;
            font-size: 0.7rem;
        }

        .status-pill span.dot {
            width: 7px;
            height: 7px;
            border-radius: 999px;
            background: #27ae60;
            box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.35);
        }

        .glass-metrics {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 10px;
            margin-bottom: 16px;
            font-size: 0.75rem;
        }

        .metric {
            padding: 8px 9px;
            border-radius: 12px;
            background: rgba(219, 219, 219, 0.35);
        }

        .metric-label {
            color: rgba(112, 111, 111, 0.85);
            margin-bottom: 2px;
        }

        .metric-value {
            font-weight: 700;
            color: var(--accent);
        }

        .mini-timeline {
            display: flex;
            gap: 6px;
            margin-bottom: 4px;
        }

        .mini-dot {
            flex: 1;
            height: 4px;
            border-radius: 999px;
            background: linear-gradient(90deg, rgba(112, 111, 111, 0.32), rgba(139, 69, 87, 0.9));
            opacity: 0.75;
        }

        .glass-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.74rem;
            color: rgba(112, 111, 111, 0.9);
        }

        .avatar-group {
            display: flex;
        }

        .avatar {
            width: 22px;
            height: 22px;
            border-radius: 999px;
            background: linear-gradient(135deg, #8B4557, #706F6F);
            border: 2px solid #ffffff;
            box-shadow: 0 4px 8px rgba(112, 111, 111, 0.4);
        }

        .avatar + .avatar {
            margin-left: -8px;
        }

        .glass-tagline {
            font-size: 0.72rem;
            color: rgba(112, 111, 111, 0.7);
        }

        .pill-orbit {
            position: absolute;
            inset: -26px -34px;
            border-radius: 32px;
            border: 1px dashed rgba(139, 69, 87, 0.28);
            border-top-color: transparent;
            border-right-color: transparent;
            transform: rotate(-3deg);
            animation: orbitLine 16s linear infinite;
            pointer-events: none;
        }

        @keyframes orbitLine {
            from { transform: rotate(-3deg); }
            to { transform: rotate(357deg); }
        }

        .ticket {
            position: absolute;
            right: -36px;
            bottom: 14px;
            width: 120px;
            padding: 10px 12px;
            border-radius: 16px;
            background: #ffffff;
            box-shadow: 0 10px 24px rgba(112, 111, 111, 0.5);
            border-left: 3px solid var(--accent);
            transform: rotate(-6deg);
            font-size: 0.7rem;
        }

        .ticket strong {
            display: block;
            margin-bottom: 3px;
            color: var(--accent);
        }

        /* Feature row */
        .features-row {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 22px;
        }

        .feature-card {
            position: relative;
            padding: 18px 18px 16px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.86);
            border: 1px solid rgba(112, 111, 111, 0.12);
            box-shadow: 0 8px 20px rgba(112, 111, 111, 0.18);
            overflow: hidden;
            opacity: 0;
            transform: translateY(18px);
            transition: opacity 0.6s ease, transform 0.6s ease, box-shadow 0.25s ease, transform 0.25s ease;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(139, 69, 87, 0.12), transparent 55%);
            opacity: 0;
            transition: opacity 0.25s ease;
            pointer-events: none;
        }

        .feature-card h3 {
            font-size: 0.95rem;
            color: var(--ink);
            margin-bottom: 6px;
        }

        .feature-card p {
            font-size: 0.82rem;
            color: rgba(112, 111, 111, 0.85);
            margin-bottom: 10px;
        }

        .feature-meta {
            font-size: 0.72rem;
            color: rgba(112, 111, 111, 0.85);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .pill {
            padding: 4px 9px;
            border-radius: 999px;
            background: var(--accent-soft);
            color: var(--accent);
            font-weight: 600;
        }

        .feature-card.in-view {
            opacity: 1;
            transform: translateY(0);
        }

        .feature-card:hover {
            box-shadow: 0 14px 30px rgba(112, 111, 111, 0.35);
            transform: translateY(-3px);
        }

        .feature-card:hover::before {
            opacity: 1;
        }

        /* Responsive */
        @media (max-width: 900px) {
            .hero {
                grid-template-columns: minmax(0, 1fr);
            }

            .hero-visual {
                order: -1;
            }

            .ticket {
                display: none;
            }
        }

        @media (max-width: 720px) {
            .page-shell {
                padding: 20px 18px 48px;
            }

            .features-row {
                grid-template-columns: minmax(0, 1fr);
            }

            .top-nav {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="hero-bg-orbit"></div>
        <div class="floating-shape shape-1"></div>
        <div class="floating-shape shape-2"></div>

        <div class="page-shell">
            <header class="top-nav">
                <div class="brand-mark">
                    <div>
                        <div class="brand-text-main">UNIVERSITY HR</div>
                        <div class="brand-text-sub">Attendance &amp; Leaves &amp; Performance</div>
                    </div>
                </div>
                <div class="nav-actions">
                    <div class="nav-pill">Team 128 - HR Management System</div>
                </div>
            </header>

            <section class="hero">
                <div class="hero-copy">
                    <div class="eyebrow">
                        <span class="eyebrow-dot"></span>
                        LIVE ATTENDANCE CONTROL
                    </div>
                    <h1>
                        One calm dashboard for<br />
                        <span>every HR decision</span>.
                    </h1>
                    <p class="hero-sub">
                        Navigate attendance, holidays, performance and employment status from a single,
                        carefully designed admin experience. Built to keep your focus on people, not on tools.
                    </p>
                    <div class="hero-meta">
                        <div class="hero-buttons">
                            <button type="button" class="btn-primary" onclick="window.location.href='AdminLogin.aspx'">
                                ADMIN LOGIN
                            </button>
                            <button type="button" class="btn-primary" onclick="window.location.href='Employee1.aspx'">
                                ACADEMIC EMPLOYEE LOGIN
                            </button>
                            <button type="button" class="btn-primary" onclick="window.location.href='HR_Login.aspx'">
                                HR EMPLOYEE LOGIN
                            </button>
                        </div>
                        <div class="hero-stat">
                            Three connected portals: Admin, Academic Employee, and HR Employee - all sharing the same database.
                        </div>
                    </div>
                    <div class="hero-footnote">
                        Designed and implemented by <strong>Team 128</strong> - Admin - Academic - HR Components
                    </div>
                </div>

                <div class="hero-visual">
                    <div class="pill-orbit"></div>
                    <div class="glass-panel">
                        <div class="glass-header">
                            <div class="glass-title">Today - Admin Snapshot</div>
                            <div class="status-pill">
                                <span class="dot"></span>
                                System healthy
                            </div>
                        </div>
                        <div class="glass-metrics">
                            <div class="metric">
                                <div class="metric-label">Total Employees</div>
                                <div class="metric-value">
                                    <asp:Label ID="lblPresentNow" runat="server" Text="0%"></asp:Label>
                                </div>
                            </div>
                            <div class="metric">
                                <div class="metric-label">On Leave</div>
                                <div class="metric-value">
                                    <asp:Label ID="lblOnLeave" runat="server" Text="0"></asp:Label>
                                </div>
                            </div>
                            <div class="metric">
                                <div class="metric-label">Pending Leave Requests</div>
                                <div class="metric-value">
                                    <asp:Label ID="lblPendingActions" runat="server" Text="0"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="mini-timeline">
                            <div class="mini-dot"></div>
                            <div class="mini-dot"></div>
                            <div class="mini-dot"></div>
                        </div>
                        <div class="glass-footer">
                            <div>
                                <div class="glass-tagline">Yesterdays records, winter performance &amp; holidays a click away.</div>
                            </div>
                            <div class="avatar-group">
                                <div class="avatar"></div>
                                <div class="avatar"></div>
                                <div class="avatar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="ticket">
                        <strong>Next step</strong>
                        Choose the login that matches your role: Admin, Academic Employee, or HR Employee.
                    </div>
                </div>
            </section>

            <section class="features-row">
                <article class="feature-card reveal">
                    <h3>Admin Component</h3>
                    <p>
                        From a single Admin dashboard you can view all employee profiles, see employees per department,
                        inspect rejected medical leaves, clean deductions for resigned employees, update todays
                        attendance, add official holidays, initiate daily attendance, fetch yesterdays
                        records and winter performance, remove holiday / day-off / approved-leave records,
                        replace employees and update employment status.
                    </p>
                    <div class="feature-meta">
                        <span class="pill">Admin Portal</span>
                        <span>Profiles, attendance, holidays, performance &amp; status updates</span>
                    </div>
                </article>

                <article class="feature-card reveal" data-delay="0.08">
                    <h3>Academic Employee Component</h3>
                    <p>
                        Academic staff log in with their ID and password to retrieve performance for a chosen semester,
                        browse current-month attendance (excluding official day-off), review last months payroll,
                        see all attendance-related deductions, apply for annual, accidental, medical, unpaid and
                        compensation leaves, track the status of their requests, and - as dean/vice-dean/president -
                        approve or reject specific leave types and evaluate employees in their department.
                    </p>
                    <div class="feature-meta">
                        <span class="pill">Academic Portal</span>
                        <span>Self-service &amp; approvals</span>
                    </div>
                </article>

                <article class="feature-card reveal" data-delay="0.16">
                    <h3>HR Employee Component</h3>
                    <p>
                        HR employees sign in to a dedicated portal where they approve or reject annual and accidental
                        leaves based on balances, manage unpaid and compensation leaves, add precise deductions for
                        missing hours, missing days and unpaid leave, and finally generate the monthly payroll,
                        with clear success and error feedback after every action.
                    </p>
                    <div class="feature-meta">
                        <span class="pill">HR Portal</span>
                        <span>Payroll &amp; leave governance</span>
                    </div>
                </article>
            </section>
        </div>
    </form>

    <script type="text/javascript">
        // Scroll reveal for feature cards
        (function () {
            var cards = document.querySelectorAll('.feature-card.reveal');
            if (!('IntersectionObserver' in window)) {
                // Fallback: show all
                for (var i = 0; i < cards.length; i++) {
                    cards[i].classList.add('in-view');
                }
                return;
            }

            var observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting) {
                        var el = entry.target;
                        var delay = el.getAttribute('data-delay') || '0';
                        el.style.transitionDelay = delay + 's';
                        el.classList.add('in-view');
                        observer.unobserve(el);
                    }
                });
            }, { threshold: 0.3 });

            cards.forEach(function (card) { observer.observe(card); });
        })();
    </script>
</body>
</html>


