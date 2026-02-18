# ============================================================
#  🛒 AISLE YOU WELL — Grocery Personality Quiz (Shiny)
#
#  HOW TO RUN:
#  1. Install packages (run once):
#     install.packages(c("shiny", "htmltools"))
#
#  2. Open this file in RStudio and click "Run App", OR:
#     shiny::runApp("grocery_quiz.R")
# ============================================================

library(shiny)
library(htmltools)

# ── Category data ─────────────────────────────────────────────
category_data <- list(
  "Alcohol" = list(
    emoji = "🍺", subtitle = "THE LIFE OF THE PARTY AISLE",
    rev = "892.4", yoy = "+8.3%", top_state = "California",
    covid = "+27%", peak = "December",
    headline = "YOU ARE THE SOCIAL LUBRICANT",
    personality = "You walk into a room and things just... happen. People relax. Conversations start. Someone ends up telling you their life story in the checkout line. You had a MASSIVE 2020 — when everyone else was panicking, you were practically flying off the shelves. Turns out people really needed you during a global crisis. You're not offended. You get it.",
    fun_fact = "FUN DATA FACT: Alcohol saw an average +27% YoY spike in March-April 2020. Coincidence? We think not.",
    best_friend = "Commercially Prepared Items", worst_enemy = "Fats and Oils",
    trait = "Still going strong at 2am"
  ),
  "Beverages" = list(
    emoji = "🥤", subtitle = "HYDRATED AND UNBOTHERED",
    rev = "743.1", yoy = "+5.1%", top_state = "Texas",
    covid = "+12%", peak = "July",
    headline = "YOU ARE THE CHILL ONE",
    personality = "You're versatile. You're everywhere. Sparkling water? That's you in a blazer. Energy drink at 3pm? Also you, but make it desperate. You don't chase trends — you ARE the trend. Your YoY growth is steady and unassuming, just like you when someone asks if you're okay and you say 'yeah totally fine' while internally you are a large Diet Coke.",
    fun_fact = "FUN DATA FACT: Beverage sales peak in July across almost every state — summer is your season, babe.",
    best_friend = "Commercially Prepared Items", worst_enemy = "Fats and Oils",
    trait = "Comes in 47 varieties, all claiming to be 'classic'"
  ),
  "Commercially prepared items" = list(
    emoji = "🍱", subtitle = "CHAOS IN A STYROFOAM CONTAINER",
    rev = "1,204.7", yoy = "+9.8%", top_state = "California",
    covid = "+31%", peak = "November",
    headline = "YOU ARE THE PRAGMATIC GENIUS",
    personality = "You don't have time for this. Or cooking. Or feelings, really. You have THINGS TO DO and you need sustenance NOW. The highest revenue category in the dataset — obviously, because you are simply built different. COVID actually helped you because suddenly everyone needed your energy: fast, no-fuss, get-it-done. You peaked during Thanksgiving week every single year. Priorities.",
    fun_fact = "FUN DATA FACT: Commercially prepared items is the single largest revenue category in the dataset at over $1.2 TRILLION across all states and years.",
    best_friend = "Beverages", worst_enemy = "Vegetables",
    trait = "Contains 'natural flavors' (unspecified)"
  ),
  "Dairy" = list(
    emoji = "🧀", subtitle = "RELIABLY THERE. OCCASIONALLY EXPIRES.",
    rev = "634.2", yoy = "+6.7%", top_state = "New York",
    covid = "+18%", peak = "December",
    headline = "YOU ARE THE DEPENDABLE ONE",
    personality = "You're not flashy. You don't need to be. You were there for breakfast. You were there for the grilled cheese when the world felt like it was ending. You had a solid COVID glow-up but you never let it go to your head. People say they're lactose intolerant until 11pm, then it's brie and crackers on the couch. You understand. You forgive. You're a little cold but you warm up.",
    fun_fact = "FUN DATA FACT: Dairy sales in New York are consistently the highest per-state of any region in the dataset. Big cheese energy.",
    best_friend = "Grains", worst_enemy = "Fats and Oils",
    trait = "Full fat until told otherwise"
  ),
  "Fats and oils" = list(
    emoji = "🫒", subtitle = "MISUNDERSTOOD. ESSENTIAL. SLIPPERY.",
    rev = "198.3", yoy = "+4.2%", top_state = "California",
    covid = "+8%", peak = "October",
    headline = "YOU ARE THE UNDERRATED BACKBONE",
    personality = "Everyone acts like they don't need you until they try to cook without you and everything sticks to the pan and they burn their eggs and it's a whole thing. You have the lowest revenue in the dataset but the MOST influence. Without you, nothing works. You're the stage crew of the grocery store — invisible until you're not there, and then suddenly everyone realizes the show can't go on. Also you just went through a whole 'olive oil era' and you loved every second of it.",
    fun_fact = "FUN DATA FACT: Fats and Oils has the smallest revenue footprint but shows up in more recipes than any other category. Underrated icon.",
    best_friend = "Vegetables", worst_enemy = "Sugar and sweeteners",
    trait = "Makes everything better, takes zero credit"
  ),
  "Fruits" = list(
    emoji = "🍎", subtitle = "ASPIRATIONAL PURCHASE. ACTUAL COMPOST.",
    rev = "412.9", yoy = "+5.9%", top_state = "California",
    covid = "+15%", peak = "June",
    headline = "YOU ARE THE OPTIMIST",
    personality = "You buy the mango on Monday with such confidence. Such purpose. This week will be different. This week you will eat the whole punnet of strawberries before they go soft. On Friday, you are composting with quiet dignity and renewed resolve for next week. But here's the thing — you keep trying. Your YoY growth is steady and honest. You peak in summer. You're everyone's aspirational self. We stan a resilient fruit person.",
    fun_fact = "FUN DATA FACT: Fruit sales peak in June/July in almost every state, then show a secondary spike in January (New Year's health kick confirmed).",
    best_friend = "Sugar and sweeteners", worst_enemy = "Commercially prepared items",
    trait = "Purchased with good intentions, returned to earth"
  ),
  "Grains" = list(
    emoji = "🌾", subtitle = "THE FOUNDATION OF CIVILIZATION AND YOUR PANTRY",
    rev = "889.3", yoy = "+7.4%", top_state = "Texas",
    covid = "+22%", peak = "March",
    headline = "YOU ARE THE PANIC BUYER",
    personality = "When things got scary in March 2020, people grabbed YOU first. Flour. Pasta. Rice. You were GONE from shelves in hours while people stress-baked sourdough and felt a sense of control over their chaotic lives. You are the first thing humans reach for in a crisis. That's not an insult — that's ancient evolutionary programming. You are quite literally the foundation of civilization. Also you really popped off during the sourdough era and we will never forget it.",
    fun_fact = "FUN DATA FACT: Grains saw one of the sharpest single-week spikes in the entire dataset in March 2020 — the great toilet paper and flour crisis of our time.",
    best_friend = "Dairy", worst_enemy = "Fats and Oils",
    trait = "Purchased in bulk, forgotten until emergency"
  ),
  "Meats" = list(
    emoji = "🥩", subtitle = "MAIN CHARACTER ENERGY",
    rev = "1,087.4", yoy = "+8.9%", top_state = "Texas",
    covid = "+19%", peak = "July",
    headline = "YOU ARE THE MAIN CHARACTER",
    personality = "You are the centerpiece. Everything else on the plate is a supporting actor. The salad? For you. The potatoes? Around you. The garnish? Honestly insulted but fine. You have absolutely massive revenue numbers, you dominate in Texas (naturally), and you really hit your stride in July when everyone fires up a grill and suddenly has a whole personality about it. You're bold, you're a little expensive, and you need 24-48 hours advance planning. Just like you.",
    fun_fact = "FUN DATA FACT: July is peak meat month across almost every state in the dataset. The entire nation grills simultaneously. Beautiful.",
    best_friend = "Vegetables", worst_enemy = "Fruits",
    trait = "Requires entire side dishes to validate your presence"
  ),
  "Other" = list(
    emoji = "🛒", subtitle = "CATEGORICALLY UNCATEGORIZABLE",
    rev = "267.8", yoy = "+4.8%", top_state = "California",
    covid = "+11%", peak = "December",
    headline = "YOU ARE THE WILDCARD",
    personality = "The data literally couldn't figure out what you are. You're in the 'Other' category. And honestly? Same. You contain multitudes. You resist simple classification. You showed up in the dataset across 43 states and nearly 4 years and the analysts just looked at you and said '...other.' You're the everything bagel. The miscellaneous drawer. The 'I'll explain it later' of groceries. People underestimate your revenue. That's their problem.",
    fun_fact = "FUN DATA FACT: 'Other' actually outperforms several named categories in total revenue, which raises profound questions about taxonomy and also snack classification.",
    best_friend = "Everyone (you contain them)", worst_enemy = "Rigid labeling systems",
    trait = "Contains at least one thing you didn't mean to buy"
  ),
  "Sugar and sweeteners" = list(
    emoji = "🍬", subtitle = "THE TREAT. THE REWARD. THE SPIRAL.",
    rev = "321.5", yoy = "+6.1%", top_state = "Georgia",
    covid = "+16%", peak = "October",
    headline = "YOU ARE THE TREAT-YOURSELF ENERGY",
    personality = "You peaked in October. Every single year. Halloween is your Super Bowl and you KNOW it. You see a slight bump in February (Valentine's Day, obvi) and again in December. You are the category of special occasions and emotional regulation. 'I deserve this' is your brand. Your YoY growth is honestly solid — people never stop needing a treat. You were up in 2020 because of course you were. We coped. We used you. We regret nothing.",
    fun_fact = "FUN DATA FACT: Sugar and Sweeteners peaks every October without fail across every state — Halloween is a $300M moment and it is GORGEOUS.",
    best_friend = "Fruits", worst_enemy = "Fats and Oils",
    trait = "Purchase justified by 'it's been a week'"
  ),
  "Vegetables" = list(
    emoji = "🥦", subtitle = "THE ONE WHO HAS THEIR LIFE TOGETHER",
    rev = "478.6", yoy = "+5.3%", top_state = "California",
    covid = "+14%", peak = "January",
    headline = "YOU ARE THE ONE WHO HAS IT TOGETHER",
    personality = "You peak in JANUARY. While everyone else is recovering from the holidays, you are already IN the gym, in the meal prep container, in the fridge with clean labeled storage bags. You saw a COVID bump because people genuinely tried to eat better during the pandemic. Were they successful? The data doesn't say. But they bought you. That has to count for something. People slightly undervalue your revenue but never your importance. Sound familiar?",
    fun_fact = "FUN DATA FACT: Vegetable sales hit their annual peak in January in most states — the New Year's Resolution Effect is real and it shows up in the data.",
    best_friend = "Fats and Oils", worst_enemy = "Commercially prepared items",
    trait = "Still in your cart even when you didn't plan to be healthy"
  )
)

# ── Questions ─────────────────────────────────────────────────
questions <- list(
  list(
    q = "It's Friday at 5pm. What are you doing?",
    opts = c(
      "Already at a bar. I ordered for the table before anyone arrived.",
      "Meal prepping for the week with a podcast on. Don't @ me.",
      "Ordering delivery and lying horizontal. It's called recovery.",
      "Firing up the grill. I've been planning this since Tuesday."
    ),
    cats = list(
      c("Alcohol","Beverages"),
      c("Vegetables","Dairy","Grains"),
      c("Commercially prepared items","Other"),
      c("Meats","Fruits")
    )
  ),
  list(
    q = "Your friends describe you as...",
    opts = c(
      "The one who makes everything better and gets no credit for it.",
      "A little chaotic but in an endearing way. Usually.",
      "Reliable. Like, almost suspiciously reliable.",
      "The main character. They say it with love. Mostly."
    ),
    cats = list(
      c("Fats and oils","Dairy","Grains"),
      c("Sugar and sweeteners","Other","Alcohol"),
      c("Beverages","Dairy","Vegetables"),
      c("Meats","Commercially prepared items")
    )
  ),
  list(
    q = "It's March 2020. What are you doing?",
    opts = c(
      "Panic-buying all the flour and learning to bake bread on day 3.",
      "Comfort ordering everything. We don't talk about the credit card statement.",
      "Organizing my pantry and creating a spreadsheet. Just in case.",
      "Honestly thriving, my sales went up 27% and I have no notes."
    ),
    cats = list(
      c("Grains","Dairy"),
      c("Commercially prepared items","Alcohol","Sugar and sweeteners"),
      c("Vegetables","Fats and oils"),
      c("Alcohol","Beverages")
    )
  ),
  list(
    q = "Pick your Sunday morning energy:",
    opts = c(
      "Farmers market, reusable bag, oat latte. Unbothered.",
      "Gas station breakfast and 44oz energy drink before noon.",
      "Elaborate brunch I've been planning since Thursday.",
      "Existential dread with a side of leftover Halloween candy."
    ),
    cats = list(
      c("Fruits","Vegetables"),
      c("Beverages","Commercially prepared items"),
      c("Meats","Dairy","Grains"),
      c("Sugar and sweeteners","Other")
    )
  ),
  list(
    q = "Your signature move at a party:",
    opts = c(
      "I AM the reason the party works. Full stop.",
      "Showing up with something no one asked for but everyone loves.",
      "Quietly making sure everyone has water and a snack. Background king/queen.",
      "Showing up late with the main dish and expecting applause."
    ),
    cats = list(
      c("Alcohol","Commercially prepared items"),
      c("Sugar and sweeteners","Fruits"),
      c("Beverages","Dairy","Fats and oils"),
      c("Meats","Other")
    )
  ),
  list(
    q = "What do people not realize about you?",
    opts = c(
      "I'm the actual foundation of everything. Literally. Look it up.",
      "I contain more than you think. Way more.",
      "My growth numbers are completely underrated. The analysts sleep on me.",
      "I am a cultural institution and will outlast all of you."
    ),
    cats = list(
      c("Grains","Fats and oils"),
      c("Other","Commercially prepared items"),
      c("Vegetables","Fruits"),
      c("Alcohol","Sugar and sweeteners")
    )
  ),
  list(
    q = "How do you handle a crisis?",
    opts = c(
      "I was born for this. Watch me go UP during the chaos.",
      "Steady as ever. I don't spike, I don't crash. I endure.",
      "I finally get the recognition I deserve. Peak month: March.",
      "I peak in October every year regardless of crisis. Seasonal icon."
    ),
    cats = list(
      c("Alcohol","Grains","Commercially prepared items"),
      c("Dairy","Beverages","Fats and oils"),
      c("Grains","Vegetables"),
      c("Sugar and sweeteners","Meats")
    )
  ),
  list(
    q = "Choose your spirit animal for grocery shopping:",
    opts = c(
      "I have a list, I have a system, I'm out in 18 minutes.",
      "I wandered in for milk. I now own three cheeses I've never heard of.",
      "I buy the same 12 things every week. I am a creature of routine.",
      "I buy whatever looks good and figure it out later. Very freeing."
    ),
    cats = list(
      c("Dairy","Grains","Vegetables"),
      c("Dairy","Other","Sugar and sweeteners"),
      c("Beverages","Meats","Commercially prepared items"),
      c("Fruits","Fats and oils","Alcohol")
    )
  )
)

n_q <- length(questions)

# ── Score calculation ─────────────────────────────────────────
calculate_result <- function(answers) {
  scores <- setNames(rep(0L, length(category_data)), names(category_data))
  for (qi in seq_along(answers)) {
    ai <- answers[[qi]]
    if (!is.null(ai) && !is.na(ai)) {
      for (cat in questions[[qi]]$cats[[ai]]) {
        if (cat %in% names(scores)) {
          scores[cat] <- scores[cat] + 1L
        }
      }
    }
  }
  names(which.max(scores))
}

# ── CSS ───────────────────────────────────────────────────────
quiz_css <- paste0(
  "@import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Bebas+Neue&family=VT323&display=swap');",
  "body{background:#2a2218;",
  "background-image:repeating-linear-gradient(90deg,rgba(255,255,255,.01) 0,transparent 1px,transparent 40px),",
  "repeating-linear-gradient(0deg,rgba(255,255,255,.01) 0,transparent 1px,transparent 40px);",
  "min-height:100vh;margin:0;padding:40px 16px 80px;",
  "display:flex;flex-direction:column;align-items:center;",
  "font-family:'Share Tech Mono',monospace;}",
  "body::before{content:'';position:fixed;inset:0;",
  "background:radial-gradient(ellipse 120% 60% at 50% -10%,rgba(200,230,200,.06) 0%,transparent 60%);",
  "pointer-events:none;animation:flicker 8s infinite;z-index:0;}",
  "@keyframes flicker{0%,96%,100%{opacity:1}97%{opacity:.85}98%{opacity:1}99%{opacity:.7}}",
  ".float-items{position:fixed;inset:0;pointer-events:none;overflow:hidden;z-index:0;}",
  ".float-item{position:absolute;opacity:.04;animation:floatUp linear infinite;}",
  "@keyframes floatUp{from{transform:translateY(100vh) rotate(0deg);opacity:0}",
  "10%{opacity:.04}90%{opacity:.04}to{transform:translateY(-20vh) rotate(360deg);opacity:0}}",
  ".receipt{background:#faf6ee;width:100%;max-width:560px;position:relative;z-index:1;",
  "box-shadow:0 0 0 1px rgba(0,0,0,.15),4px 4px 0 rgba(0,0,0,.2),8px 8px 0 rgba(0,0,0,.1),0 20px 60px rgba(0,0,0,.5);",
  "clip-path:polygon(0% 0%,2% .4%,4% 0%,6% .5%,8% .1%,10% .4%,12% 0%,14% .3%,16% 0%,18% .5%,",
  "20% .1%,22% .4%,24% 0%,26% .3%,28% 0%,30% .5%,32% .1%,34% .4%,36% 0%,38% .3%,",
  "40% 0%,42% .5%,44% .1%,46% .4%,48% 0%,50% .3%,52% 0%,54% .5%,56% .1%,58% .4%,",
  "60% 0%,62% .3%,64% 0%,66% .5%,68% .1%,70% .4%,72% 0%,74% .3%,76% 0%,78% .5%,",
  "80% .1%,82% .4%,84% 0%,86% .3%,88% 0%,90% .5%,92% .1%,94% .4%,96% 0%,98% .3%,100% 0%,",
  "100% 100%,98% 99.6%,96% 100%,94% 99.5%,92% 100%,90% 99.6%,88% 100%,86% 99.5%,84% 100%,",
  "82% 99.6%,80% 100%,78% 99.5%,76% 100%,74% 99.6%,72% 100%,70% 99.5%,68% 100%,66% 99.6%,",
  "64% 100%,62% 99.5%,60% 100%,58% 99.6%,56% 100%,54% 99.5%,52% 100%,50% 99.6%,48% 100%,",
  "46% 99.5%,44% 100%,42% 99.6%,40% 100%,38% 99.5%,36% 100%,34% 99.6%,32% 100%,30% 99.5%,",
  "28% 100%,26% 99.6%,24% 100%,22% 99.5%,20% 100%,18% 99.6%,16% 100%,14% 99.5%,12% 100%,",
  "10% 99.6%,8% 100%,6% 99.5%,4% 100%,2% 99.6%,0% 100%)}",
  ".receipt-inner{",
  "background-image:repeating-linear-gradient(0deg,transparent,transparent 23px,rgba(0,0,0,.04) 23px,rgba(0,0,0,.04) 24px);",
  "padding:32px 32px 24px;}",
  ".store-header{text-align:center;border-bottom:2px dashed #4a3f2f;padding-bottom:20px;margin-bottom:20px;}",
  ".store-name{font-family:'Bebas Neue',sans-serif;font-size:52px;letter-spacing:.08em;color:#1a1208;line-height:1;}",
  ".store-tagline{font-family:'VT323',monospace;font-size:18px;color:#4a3f2f;letter-spacing:.1em;margin-top:4px;}",
  ".store-meta{font-size:11px;color:#4a3f2f;margin-top:8px;letter-spacing:.08em;}",
  ".barcode{display:flex;justify-content:center;margin:12px 0 4px;gap:1px;}",
  ".barcode-text{text-align:center;font-size:10px;color:#4a3f2f;letter-spacing:.3em;}",
  ".section-header{font-family:'Bebas Neue',sans-serif;font-size:13px;letter-spacing:.2em;",
  "color:#4a3f2f;text-align:center;margin:20px 0 16px;}",
  ".progress-row{display:flex;align-items:center;gap:10px;margin-bottom:20px;}",
  ".progress-label{font-size:10px;color:#4a3f2f;letter-spacing:.1em;white-space:nowrap;}",
  ".progress-track{flex:1;height:6px;background:#f0e8d5;border:1px solid rgba(0,0,0,.15);overflow:hidden;}",
  ".progress-fill{height:100%;background:#1a1208;transition:width .4s ease;}",
  ".question-block{margin-bottom:28px;}",
  ".question-num{font-size:10px;color:#4a3f2f;letter-spacing:.15em;margin-bottom:4px;}",
  ".question-text{font-family:'VT323',monospace;font-size:22px;color:#1a1208;line-height:1.3;margin-bottom:12px;}",
  ".options{display:flex;flex-direction:column;gap:6px;}",
  ".option{display:flex;align-items:flex-start;gap:10px;padding:9px 12px;",
  "border:1.5px solid transparent;border-radius:2px;cursor:pointer;transition:all .15s;",
  "background:transparent;text-align:left;font-family:'Share Tech Mono',monospace;",
  "font-size:13px;color:#1a1208;line-height:1.4;width:100%;}",
  ".option:hover{border-color:#1a6b2a;background:rgba(26,107,42,.08);}",
  ".option-selected{border-color:#1a6b2a !important;background:rgba(26,107,42,.1) !important;}",
  ".option-selected .opt-letter{background:#1a6b2a !important;color:white !important;border-color:#1a6b2a !important;}",
  ".opt-letter{display:inline-flex;align-items:center;justify-content:center;",
  "width:22px;height:22px;min-width:22px;border:1.5px solid #4a3f2f;font-size:11px;font-weight:bold;}",
  ".divider{border:none;border-top:1px dashed #4a3f2f;margin:20px 0;}",
  ".divider-double{border:none;border-top:2px solid #1a1208;margin:20px 0;}",
  ".divider-double::after{content:'';display:block;border-top:1px solid #1a1208;margin-top:3px;}",
  ".submit-btn{display:block;width:100%;padding:14px;background:#1a1208;color:#faf6ee;",
  "font-family:'Bebas Neue',sans-serif;font-size:24px;letter-spacing:.15em;",
  "border:none;cursor:pointer;transition:all .15s;margin-top:8px;}",
  ".submit-btn:hover:not([disabled]){background:#1a6b2a;letter-spacing:.2em;}",
  ".submit-btn[disabled]{opacity:.4;cursor:not-allowed;}",
  ".scan-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.85);",
  "z-index:100;align-items:center;justify-content:center;flex-direction:column;gap:20px;}",
  ".scan-overlay.active{display:flex;}",
  ".scan-box{width:220px;height:140px;border:2px solid #00ff41;position:relative;",
  "box-shadow:0 0 20px rgba(0,255,65,.4),inset 0 0 20px rgba(0,255,65,.1);}",
  ".scan-line{position:absolute;left:0;right:0;height:2px;",
  "background:linear-gradient(90deg,transparent,#00ff41,transparent);",
  "box-shadow:0 0 8px #00ff41;animation:scanMove 1.5s ease-in-out infinite;top:0;}",
  "@keyframes scanMove{0%{top:0}50%{top:calc(100% - 2px)}100%{top:0}}",
  ".scan-corner{position:absolute;width:16px;height:16px;border-color:#00ff41;border-style:solid;}",
  ".scan-corner.tl{top:-2px;left:-2px;border-width:3px 0 0 3px;}",
  ".scan-corner.tr{top:-2px;right:-2px;border-width:3px 3px 0 0;}",
  ".scan-corner.bl{bottom:-2px;left:-2px;border-width:0 0 3px 3px;}",
  ".scan-corner.br{bottom:-2px;right:-2px;border-width:0 3px 3px 0;}",
  ".scan-text{font-family:'VT323',monospace;font-size:28px;color:#00ff41;",
  "letter-spacing:.15em;text-shadow:0 0 10px #00ff41;animation:blink .8s step-end infinite;}",
  "@keyframes blink{50%{opacity:0}}",
  ".scan-subtext{font-family:'Share Tech Mono',monospace;font-size:11px;",
  "color:rgba(0,255,65,.6);letter-spacing:.2em;}",
  ".result-stamp{text-align:center;margin-bottom:20px;}",
  ".stamp-circle{display:inline-block;border:4px solid #cc1200;border-radius:50%;",
  "padding:16px 20px;transform:rotate(-8deg);}",
  ".stamp-text{font-family:'Bebas Neue',sans-serif;font-size:13px;letter-spacing:.2em;color:#cc1200;}",
  ".stamp-result{font-family:'Bebas Neue',sans-serif;font-size:28px;letter-spacing:.1em;color:#cc1200;line-height:1;}",
  ".result-emoji{font-size:64px;text-align:center;display:block;margin:12px 0;}",
  ".result-title{font-family:'Bebas Neue',sans-serif;font-size:42px;color:#1a1208;",
  "text-align:center;letter-spacing:.05em;line-height:1;}",
  ".result-subtitle{font-family:'VT323',monospace;font-size:20px;color:#1a6b2a;",
  "text-align:center;letter-spacing:.1em;margin-top:4px;}",
  ".stats-block{background:#f0e8d5;border:1px dashed #4a3f2f;padding:14px;margin:16px 0;}",
  ".stat-line{display:flex;justify-content:space-between;align-items:baseline;",
  "font-size:13px;color:#1a1208;padding:3px 0;border-bottom:1px dotted rgba(0,0,0,.12);}",
  ".stat-line:last-child{border-bottom:none;}",
  ".stat-lbl{color:#4a3f2f;}",
  ".stat-val{font-weight:bold;}",
  ".stat-total{font-family:'Bebas Neue',sans-serif;font-size:18px;letter-spacing:.05em;",
  "border-top:2px solid #1a1208;margin-top:6px;padding-top:8px;border-bottom:none;}",
  ".personality-box{background:white;border-left:4px solid #cc1200;padding:14px 16px;",
  "margin:16px 0;font-size:14px;color:#1a1208;line-height:1.7;}",
  ".p-headline{font-family:'VT323',monospace;font-size:22px;color:#cc1200;margin-bottom:6px;}",
  ".fun-fact{font-size:12px;color:#4a3f2f;border-top:1px dashed #4a3f2f;",
  "padding-top:10px;margin-top:10px;line-height:1.6;font-style:italic;}",
  ".retake-btn{display:block;width:100%;padding:12px;background:transparent;color:#1a1208;",
  "font-family:'Share Tech Mono',monospace;font-size:13px;letter-spacing:.1em;",
  "border:1.5px dashed #4a3f2f;cursor:pointer;transition:all .15s;margin-top:10px;",
  "text-transform:uppercase;}",
  ".retake-btn:hover{border-color:#1a1208;background:#f0e8d5;}",
  ".share-line{text-align:center;font-size:11px;color:#4a3f2f;margin-top:16px;letter-spacing:.1em;}",
  ".thank-you{text-align:center;padding:20px 0 10px;font-family:'VT323',monospace;",
  "font-size:20px;color:#4a3f2f;letter-spacing:.15em;}",
  ".grn{color:#1a6b2a;font-weight:bold;}"
)

# ── JS helpers ────────────────────────────────────────────────
quiz_js <- "
function createFloatingItems() {
  var emojis = ['\U0001F6D2','\U0001F955','\U0001F9C0','\U0001F37A','\U0001F33E',
                '\U0001F34E','\U0001F966','\U0001F969','\U0FAD2','\U0001F36C',
                '\U0001F964','\U0001F371'];
  var container = document.getElementById('float-items');
  if (!container) return;
  emojis.forEach(function(emoji, i) {
    var el = document.createElement('div');
    el.className = 'float-item';
    el.textContent = emoji;
    el.style.cssText = 'left:' + ((i*97+13)%100) + '%;' +
      'animation-duration:' + (15+(i*7)%20) + 's;' +
      'animation-delay:' + ((i*3)%12) + 's;' +
      'font-size:' + (20+(i*11)%20) + 'px;';
    container.appendChild(el);
  });
}

function generateBarcode(containerId, seed) {
  var container = document.getElementById(containerId);
  if (!container) return;
  var html = '', s = seed || 12345;
  for (var i = 0; i < 60; i++) {
    s = (s * 1103515245 + 12345) & 0x7fffffff;
    var h = 20 + (s % 25);
    var w = 1 + (s % 3 > 1 ? 1 : 0);
    html += '<div style=\"width:' + w + 'px;height:' + h + 'px;background:#1a1208;\"></div>';
    if (s % 4 === 0) html += '<div style=\"width:1px;height:' + h + 'px;\"></div>';
  }
  container.innerHTML = html;
}

function triggerScan() {
  var overlay = document.getElementById('scan-overlay');
  overlay.classList.add('active');
  setTimeout(function() {
    overlay.classList.remove('active');
    Shiny.setInputValue('scan_done', Math.random());
  }, 2200);
}

document.addEventListener('DOMContentLoaded', function() {
  createFloatingItems();
  generateBarcode('barcode-svg', 98765);
});
"

# ── UI ────────────────────────────────────────────────────────
ui <- fluidPage(
  tags$head(
    tags$style(HTML(quiz_css)),
    tags$script(HTML(quiz_js))
  ),

  div(class = "float-items", id = "float-items"),

  div(class = "scan-overlay", id = "scan-overlay",
    div(class = "scan-box",
      div(class = "scan-line"),
      div(class = "scan-corner tl"),
      div(class = "scan-corner tr"),
      div(class = "scan-corner bl"),
      div(class = "scan-corner br")
    ),
    div(class = "scan-text", "SCANNING..."),
    div(class = "scan-subtext", "ANALYZING YOUR PERSONALITY")
  ),

  div(class = "receipt",
    div(class = "receipt-inner",
      div(class = "store-header",
        div(class = "store-name", "AISLE YOU WELL"),
        div(class = "store-tagline", "YOUR NEIGHBORHOOD PERSONALITY GROCER"),
        div(class = "store-meta",
          HTML("EST. 2019 &nbsp;|&nbsp; 43 STATES SERVED &nbsp;|&nbsp; 88,924 DATA POINTS SCANNED<br>OPEN 24/7 EXCEPT WHEN WE'RE CLOSED")
        ),
        div(class = "barcode", id = "barcode-svg"),
        div(class = "barcode-text", "QUIZ-2024-PERSONALITY-ASSESSMENT")
      ),
      uiOutput("quiz_ui"),
      uiOutput("result_ui")
    )
  )
)

# ── Server ────────────────────────────────────────────────────
server <- function(input, output, session) {

  answers     <- reactiveVal(rep(NA_integer_, n_q))
  show_result <- reactiveVal(FALSE)

  # Observe each answer button
  lapply(seq_len(n_q), function(qi) {
    lapply(seq_len(4), function(oi) {
      local({
        local_qi <- qi
        local_oi <- oi
        btn_id <- paste0("q", local_qi, "_opt", local_oi)
        observeEvent(input[[btn_id]], {
          ans <- answers()
          ans[local_qi] <- local_oi
          answers(ans)
        }, ignoreInit = TRUE)
      })
    })
  })

  # Scan animation finished -> show result
  observeEvent(input$scan_done, {
    show_result(TRUE)
  })

  # Retake button
  observeEvent(input$retake_btn, {
    answers(rep(NA_integer_, n_q))
    show_result(FALSE)
  })

  # ── Quiz UI ────────────────────────────────────────────────
  output$quiz_ui <- renderUI({
    if (show_result()) return(NULL)

    ans      <- answers()
    answered <- sum(!is.na(ans))
    pct      <- round(answered / n_q * 100)
    all_done <- (answered == n_q)

    q_blocks <- lapply(seq_len(n_q), function(qi) {
      q   <- questions[[qi]]
      sel <- if (!is.na(ans[qi])) ans[qi] else 0L

      opt_btns <- lapply(seq_len(4), function(oi) {
        btn_id  <- paste0("q", qi, "_opt", oi)
        is_sel  <- (sel == oi)
        cls     <- if (is_sel) "option option-selected" else "option"
        tags$button(
          id      = btn_id,
          class   = cls,
          onclick = sprintf("Shiny.setInputValue('%s', %d, {priority: 'event'})", btn_id, oi),
          tags$span(class = "opt-letter", LETTERS[oi]),
          tags$span(q$opts[oi])
        )
      })

      tagList(
        div(class = "question-block",
          div(class = "question-num", sprintf("ITEM %02d OF %02d", qi, n_q)),
          div(class = "question-text", q$q),
          div(class = "options", opt_btns)
        ),
        if (qi < n_q) tags$hr(class = "divider")
      )
    })

    submit_btn <- if (all_done) {
      tags$button(
        class   = "submit-btn",
        onclick = "triggerScan()",
        "SCAN MY PERSONALITY"
      )
    } else {
      tags$button(
        class    = "submit-btn",
        disabled = "disabled",
        "SCAN MY PERSONALITY"
      )
    }

    tagList(
      div(class = "section-header", "PERSONALITY SCAN INITIATED"),
      div(class = "progress-row",
        span(class = "progress-label", "ITEMS SCANNED:"),
        div(class = "progress-track",
          div(class = "progress-fill", style = sprintf("width:%d%%", pct))
        ),
        span(class = "progress-label", sprintf("%d / %d", answered, n_q))
      ),
      q_blocks,
      tags$hr(class = "divider-double"),
      submit_btn
    )
  })

  # ── Result UI ─────────────────────────────────────────────
  output$result_ui <- renderUI({
    if (!show_result()) return(NULL)

    ans <- answers()
    cat <- calculate_result(as.list(ans))
    d   <- category_data[[cat]]

    bc_seed <- nchar(cat) * 7919
    bc_js   <- paste0(
      "<script>",
      "setTimeout(function(){generateBarcode('result-barcode',", bc_seed, ");},100);",
      "<", "/script>"
    )

    tagList(
      div(class = "section-header", "PERSONALITY SCAN COMPLETE"),

      div(class = "result-stamp",
        div(class = "stamp-circle",
          div(class = "stamp-text", "YOU ARE:"),
          div(class = "stamp-result", toupper(cat))
        )
      ),

      tags$span(class = "result-emoji", d$emoji),
      div(class = "result-title",    toupper(cat)),
      div(class = "result-subtitle", d$subtitle),

      tags$hr(class = "divider"),
      div(class = "section-header", "YOUR AISLE STATS (REAL DATA)"),

      div(class = "stats-block",
        div(class = "stat-line",
          span(class = "stat-lbl", "TOTAL REVENUE (2019-2023)"),
          span(class = "stat-val", paste0("$", d$rev, "B"))
        ),
        div(class = "stat-line",
          span(class = "stat-lbl", "AVG YOY GROWTH"),
          span(class = "stat-val grn", d$yoy)
        ),
        div(class = "stat-line",
          span(class = "stat-lbl", "TOP STATE"),
          span(class = "stat-val", toupper(d$top_state))
        ),
        div(class = "stat-line",
          span(class = "stat-lbl", "COVID BUMP (2020)"),
          span(class = "stat-val grn", d$covid)
        ),
        div(class = "stat-line",
          span(class = "stat-lbl", "PEAK MONTH"),
          span(class = "stat-val", toupper(d$peak))
        ),
        div(class = "stat-line stat-total",
          span("YOUR AISLE"),
          span(paste(d$emoji, toupper(cat)))
        )
      ),

      tags$hr(class = "divider"),
      div(class = "section-header", "PERSONALITY ANALYSIS"),

      div(class = "personality-box",
        div(class = "p-headline", d$headline),
        p(d$personality),
        div(class = "fun-fact", d$fun_fact)
      ),

      tags$hr(class = "divider"),
      div(class = "section-header", "COMPATIBILITY"),

      div(class = "stats-block",
        div(class = "stat-line",
          span(class = "stat-lbl", "BEST GROCERY PAIRING"),
          span(class = "stat-val", d$best_friend)
        ),
        div(class = "stat-line",
          span(class = "stat-lbl", "AVOIDED IN MEAL PLANNING"),
          span(class = "stat-val", d$worst_enemy)
        ),
        div(class = "stat-line",
          span(class = "stat-lbl", "SIGNATURE TRAIT"),
          span(class = "stat-val", toupper(d$trait))
        )
      ),

      tags$hr(class = "divider-double"),

      div(class = "thank-you",
        HTML("THANK YOU FOR SHOPPING AT AISLE YOU WELL<br>CASHIER: CLAUDE &nbsp; TERMINAL: 07<br><span style='font-size:14px;'>HAVE YOU TRIED OUR REWARDS PROGRAM?<br>(WE ALSO DON'T HAVE ONE)</span>")
      ),

      div(class = "barcode", id = "result-barcode"),
      div(class = "barcode-text",
        paste0("RESULT-", gsub(" ", "-", toupper(cat)))
      ),

      HTML(bc_js),

      tags$button(
        id      = "retake_btn",
        class   = "retake-btn",
        onclick = "Shiny.setInputValue('retake_btn', Math.random(), {priority:'event'})",
        "RESCAN YOUR PERSONALITY"
      ),

      div(class = "share-line",
        "PRINT THIS RECEIPT AND SHOW YOUR FRIENDS. OR DON'T. WE'RE A RECEIPT, NOT A COP."
      )
    )
  })
}

shinyApp(ui, server)
