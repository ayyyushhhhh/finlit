import 'package:flutter/material.dart';
import 'package:finlit/models/category_model.dart';
import 'package:finlit/models/lesson_model.dart';
import 'package:finlit/models/question_model.dart';
import 'package:finlit/constants/app_constants.dart';

class LessonData {
  static List<CategoryModel> getAllCategories() {
    return [
      _budgetingCategory(),
      _savingCategory(),
      _investingCategory(),
      _creditCategory(),
    ];
  }

  // ─── CATEGORY 1: BUDGETING ────────────────────────────────────────────

  static CategoryModel _budgetingCategory() {
    return CategoryModel(
      categoryId: 'budgeting',
      title: 'Budgeting',
      description: 'Learn to manage your money wisely with budgeting basics.',
      icon: Icons.account_balance_wallet,
      themeColor: AppConstants.budgetingColor,
      orderIndex: 0,
      lessons: [
        _budgetingLesson1(),
        _budgetingLesson2(),
        _budgetingLesson3(),
        _budgetingLesson4(),
        _budgetingLesson5(),
      ],
    );
  }

  static LessonModel _budgetingLesson1() {
    return const LessonModel(
      lessonId: 'budgeting_01',
      categoryId: 'budgeting',
      title: 'Needs vs Wants',
      estimatedMinutes: 5,
      orderIndex: 0,
      content:
          'Understanding the difference between needs and wants is the foundation of smart money management.\n\n'
          '**Needs** are things you must have to survive and function in daily life. These include food, shelter, clothing, healthcare, and basic transportation.\n\n'
          '**Wants** are things that are nice to have but you can live without. These include eating out, streaming services, designer clothes, and the latest gadgets.\n\n'
          'A simple test: Ask yourself, "Can I survive without this?" If yes, it\'s probably a want.\n\n'
          'The key to good budgeting is making sure your needs are covered first, and then deciding how much of your remaining money goes toward wants and savings.',
      example:
          'Rahul earns ₹25,000/month. His rent (₹8,000), groceries (₹4,000), and bus pass (₹1,500) are needs – totalling ₹13,500. '
          'His Netflix subscription (₹649), eating out (₹3,000), and new headphones (₹2,000) are wants. '
          'By identifying needs first, Rahul knows he has ₹11,500 left for wants and savings.',
      questions: [
        QuestionModel(
          questionId: 'b1_q1',
          questionText: 'Which of the following is a "need"?',
          options: ['Latest iPhone', 'Monthly rent', 'Movie tickets', 'Designer shoes'],
          correctAnswerIndex: 1,
          explanation: 'Rent is a basic necessity for shelter – one of the most fundamental human needs.',
        ),
        QuestionModel(
          questionId: 'b1_q2',
          questionText: 'What is the simple test to determine if something is a want?',
          options: [
            'Is it expensive?',
            'Do my friends have it?',
            'Can I survive without it?',
            'Is it on sale?'
          ],
          correctAnswerIndex: 2,
          explanation: 'If you can survive without something, it\'s a want, not a need.',
        ),
        QuestionModel(
          questionId: 'b1_q3',
          questionText: 'Which should be covered first in a budget?',
          options: ['Wants', 'Entertainment', 'Needs', 'Investments'],
          correctAnswerIndex: 2,
          explanation: 'Needs should always be covered first before allocating money to wants or savings.',
        ),
        QuestionModel(
          questionId: 'b1_q4',
          questionText: 'A streaming subscription like Netflix is typically a:',
          options: ['Need', 'Want', 'Investment', 'Emergency expense'],
          correctAnswerIndex: 1,
          explanation: 'Entertainment subscriptions are wants – you can live without them.',
        ),
      ],
    );
  }

  static LessonModel _budgetingLesson2() {
    return const LessonModel(
      lessonId: 'budgeting_02',
      categoryId: 'budgeting',
      title: 'Creating a Monthly Budget',
      estimatedMinutes: 6,
      orderIndex: 1,
      content:
          'A monthly budget is a plan for how you will spend your money each month. One popular method is the **50/30/20 Rule**.\n\n'
          '**50% – Needs**: Rent, groceries, utilities, insurance, minimum loan payments.\n\n'
          '**30% – Wants**: Dining out, hobbies, shopping, entertainment.\n\n'
          '**20% – Savings & Debt Repayment**: Emergency fund, investments, extra loan payments.\n\n'
          'Steps to create your budget:\n'
          '1. Calculate your total monthly income (after tax)\n'
          '2. List all your fixed expenses (rent, utilities)\n'
          '3. List variable expenses (food, transport)\n'
          '4. Allocate remaining money using the 50/30/20 rule\n'
          '5. Track and adjust monthly',
      example:
          'Priya earns ₹30,000/month after tax.\n'
          '• 50% Needs (₹15,000): Rent ₹10,000 + Groceries ₹3,000 + Transport ₹2,000\n'
          '• 30% Wants (₹9,000): Eating out ₹3,000 + Shopping ₹3,000 + Entertainment ₹3,000\n'
          '• 20% Savings (₹6,000): Emergency fund ₹3,000 + SIP investment ₹3,000\n'
          'This way, every rupee has a purpose!',
      questions: [
        QuestionModel(
          questionId: 'b2_q1',
          questionText: 'In the 50/30/20 rule, what percentage goes to needs?',
          options: ['20%', '30%', '50%', '60%'],
          correctAnswerIndex: 2,
          explanation: 'The 50/30/20 rule allocates 50% of income to essential needs.',
        ),
        QuestionModel(
          questionId: 'b2_q2',
          questionText: 'What is the first step in creating a budget?',
          options: [
            'List your wants',
            'Calculate total monthly income',
            'Open a savings account',
            'Cut all unnecessary expenses'
          ],
          correctAnswerIndex: 1,
          explanation: 'You need to know how much money you have before deciding how to spend it.',
        ),
        QuestionModel(
          questionId: 'b2_q3',
          questionText: 'If you earn ₹40,000/month, how much should go to savings (20%)?',
          options: ['₹4,000', '₹6,000', '₹8,000', '₹12,000'],
          correctAnswerIndex: 2,
          explanation: '20% of ₹40,000 = ₹8,000 should go toward savings and debt repayment.',
        ),
        QuestionModel(
          questionId: 'b2_q4',
          questionText: 'Which of these is a fixed expense?',
          options: ['Grocery shopping', 'Monthly rent', 'Weekend dining', 'Movie tickets'],
          correctAnswerIndex: 1,
          explanation: 'Rent is fixed – it stays the same every month unlike variable expenses.',
        ),
      ],
    );
  }

  static LessonModel _budgetingLesson3() {
    return const LessonModel(
      lessonId: 'budgeting_03',
      categoryId: 'budgeting',
      title: 'Building an Emergency Fund',
      estimatedMinutes: 5,
      orderIndex: 2,
      content:
          'An **emergency fund** is money set aside for unexpected expenses or financial emergencies.\n\n'
          'Why is it important?\n'
          '• Job loss or reduced income\n'
          '• Medical emergencies\n'
          '• Car or bike repairs\n'
          '• Unexpected travel\n\n'
          'How much should you save?\n'
          'Financial experts recommend **3 to 6 months** of essential expenses.\n\n'
          'Where to keep it?\n'
          'A separate savings account that is easily accessible but not your main spending account.\n\n'
          'How to start?\n'
          '• Start small – even ₹500/month\n'
          '• Set up automatic transfers\n'
          '• Don\'t touch it for non-emergencies\n'
          '• Replenish it if you use it',
      example:
          'Amit\'s monthly essential expenses are ₹20,000. He aims for a 3-month emergency fund = ₹60,000. '
          'He starts saving ₹5,000/month into a separate savings account. In 12 months, he has his full emergency fund. '
          'When his laptop suddenly broke, he could cover the ₹15,000 repair without using credit cards or borrowing.',
      questions: [
        QuestionModel(
          questionId: 'b3_q1',
          questionText: 'How many months of expenses should an emergency fund cover?',
          options: ['1 month', '3 to 6 months', '12 months', '24 months'],
          correctAnswerIndex: 1,
          explanation: 'Experts recommend 3-6 months of essential expenses in your emergency fund.',
        ),
        QuestionModel(
          questionId: 'b3_q2',
          questionText: 'Where should you keep your emergency fund?',
          options: [
            'Under your mattress',
            'In stocks',
            'A separate savings account',
            'Your main spending account'
          ],
          correctAnswerIndex: 2,
          explanation: 'A separate savings account keeps it accessible but away from daily spending temptation.',
        ),
        QuestionModel(
          questionId: 'b3_q3',
          questionText: 'Which is NOT a valid reason to use your emergency fund?',
          options: [
            'Medical emergency',
            'Job loss',
            'Buying a new gaming console',
            'Car breakdown'
          ],
          correctAnswerIndex: 2,
          explanation: 'A gaming console is a want, not an emergency. Emergency funds are for unexpected necessities.',
        ),
      ],
    );
  }

  static LessonModel _budgetingLesson4() {
    return const LessonModel(
      lessonId: 'budgeting_04',
      categoryId: 'budgeting',
      title: 'Tracking Your Spending',
      estimatedMinutes: 5,
      orderIndex: 3,
      content:
          'You can\'t improve what you don\'t measure. **Tracking your spending** helps you understand where your money goes.\n\n'
          'Methods to track expenses:\n\n'
          '**1. Notebook method**: Write down every purchase daily.\n\n'
          '**2. Spreadsheet**: Use Google Sheets or Excel with categories.\n\n'
          '**3. Apps**: Use budgeting apps that automatically categorize transactions.\n\n'
          '**4. Bank statements**: Review monthly statements to see spending patterns.\n\n'
          'Tips for effective tracking:\n'
          '• Record expenses immediately – don\'t wait\n'
          '• Categorize every expense (food, transport, etc.)\n'
          '• Review weekly to spot overspending\n'
          '• Compare actual spending to your budget\n'
          '• Look for patterns and adjust',
      example:
          'Neha started tracking her spending and discovered she was spending ₹4,500/month on food delivery apps – '
          'much more than the ₹2,000 she had budgeted. By cooking at home 4 days a week and limiting delivery to weekends, '
          'she reduced food spending to ₹2,500 and saved ₹2,000 extra each month.',
      questions: [
        QuestionModel(
          questionId: 'b4_q1',
          questionText: 'Why is tracking spending important?',
          options: [
            'To impress your friends',
            'To understand where your money goes',
            'To earn more money',
            'To get bank rewards'
          ],
          correctAnswerIndex: 1,
          explanation: 'Tracking helps you see your actual spending patterns and find areas to improve.',
        ),
        QuestionModel(
          questionId: 'b4_q2',
          questionText: 'How often should you review your tracked expenses?',
          options: ['Once a year', 'Every 6 months', 'Weekly', 'Never'],
          correctAnswerIndex: 2,
          explanation: 'Weekly reviews help you catch overspending early before it becomes a habit.',
        ),
        QuestionModel(
          questionId: 'b4_q3',
          questionText: 'What should you do when you notice you\'re overspending in a category?',
          options: [
            'Ignore it',
            'Stop tracking',
            'Adjust your habits or budget',
            'Earn more money'
          ],
          correctAnswerIndex: 2,
          explanation: 'The purpose of tracking is to identify and correct overspending patterns.',
        ),
      ],
    );
  }

  static LessonModel _budgetingLesson5() {
    return const LessonModel(
      lessonId: 'budgeting_05',
      categoryId: 'budgeting',
      title: 'Adjusting Your Budget',
      estimatedMinutes: 5,
      orderIndex: 4,
      content:
          'Life changes, and your budget should change with it. A budget isn\'t set in stone – it needs regular updates.\n\n'
          'When to adjust your budget:\n'
          '• Income increase or decrease\n'
          '• Moving to a new city/home\n'
          '• Starting or finishing college\n'
          '• New recurring expenses (subscriptions, loan EMIs)\n'
          '• Life events (marriage, new job)\n\n'
          'How to adjust:\n'
          '1. Review your current income and expenses\n'
          '2. Identify what has changed\n'
          '3. Reallocate amounts to categories\n'
          '4. Keep the 50/30/20 ratio as a guideline\n'
          '5. Test the new budget for one month\n'
          '6. Adjust again if needed',
      example:
          'Vikram was living with his parents (no rent) and spending 70% on wants. When he moved out for a job, '
          'rent (₹12,000) and utilities (₹3,000) became new expenses. He restructured: Needs jumped from 20% to 50%, '
          'wants dropped from 70% to 25%, and he maintained 25% savings. His budget adapted to his new life.',
      questions: [
        QuestionModel(
          questionId: 'b5_q1',
          questionText: 'How often should you review your budget?',
          options: ['Never', 'Every 5 years', 'Regularly, especially when life changes', 'Only once'],
          correctAnswerIndex: 2,
          explanation: 'Regular reviews, especially during life changes, ensure your budget stays relevant.',
        ),
        QuestionModel(
          questionId: 'b5_q2',
          questionText: 'What should happen to your budget when you get a raise?',
          options: [
            'Spend it all on wants',
            'Keep the same budget and save the extra',
            'Review and adjust allocations',
            'Nothing – ignore the raise'
          ],
          correctAnswerIndex: 2,
          explanation: 'A raise is a good time to review your budget and potentially increase savings.',
        ),
        QuestionModel(
          questionId: 'b5_q3',
          questionText: 'Moving out of your parents\' home will mostly affect which budget category?',
          options: ['Entertainment', 'Needs (rent, utilities)', 'Investments', 'None'],
          correctAnswerIndex: 1,
          explanation: 'New housing expenses like rent and utilities are needs that significantly impact your budget.',
        ),
      ],
    );
  }

  // ─── CATEGORY 2: SAVING & INTEREST ────────────────────────────────────

  static CategoryModel _savingCategory() {
    return CategoryModel(
      categoryId: 'saving',
      title: 'Saving & Interest',
      description: 'Understand how saving and interest can grow your money.',
      icon: Icons.savings,
      themeColor: AppConstants.savingColor,
      orderIndex: 1,
      lessons: [
        _savingLesson1(),
        _savingLesson2(),
        _savingLesson3(),
        _savingLesson4(),
        _savingLesson5(),
      ],
    );
  }

  static LessonModel _savingLesson1() {
    return const LessonModel(
      lessonId: 'saving_01',
      categoryId: 'saving',
      title: 'Types of Bank Accounts',
      estimatedMinutes: 5,
      orderIndex: 0,
      content:
          'Banks offer different types of accounts based on your needs.\n\n'
          '**1. Savings Account**\n'
          '• For storing money you don\'t need immediately\n'
          '• Earns a small interest (3-7% per year in India)\n'
          '• Easy to withdraw money anytime\n\n'
          '**2. Current Account**\n'
          '• For businesses and frequent transactions\n'
          '• Usually no interest earned\n'
          '• No limit on transactions\n\n'
          '**3. Fixed Deposit (FD)**\n'
          '• Lock your money for a fixed period (6 months to 10 years)\n'
          '• Higher interest rate than savings account\n'
          '• Penalty for early withdrawal\n\n'
          '**4. Recurring Deposit (RD)**\n'
          '• Deposit a fixed amount every month\n'
          '• Good for building savings habit\n'
          '• Fixed interest rate',
      example:
          'Simran opened a savings account for daily expenses (earns 4% interest), and a Fixed Deposit of ₹50,000 '
          'for 1 year at 7% interest. Her savings account gives flexibility while the FD gives higher returns on '
          'money she doesn\'t need immediately. After 1 year, her FD grows to ₹53,500.',
      questions: [
        QuestionModel(
          questionId: 's1_q1',
          questionText: 'Which account type is best for storing emergency funds?',
          options: ['Current Account', 'Fixed Deposit', 'Savings Account', 'Loan Account'],
          correctAnswerIndex: 2,
          explanation: 'A savings account offers easy access (important for emergencies) while earning some interest.',
        ),
        QuestionModel(
          questionId: 's1_q2',
          questionText: 'Which account typically offers the highest interest rate?',
          options: ['Savings Account', 'Current Account', 'Fixed Deposit', 'None – banks don\'t pay interest'],
          correctAnswerIndex: 2,
          explanation: 'Fixed deposits offer higher interest because your money is locked for a set period.',
        ),
        QuestionModel(
          questionId: 's1_q3',
          questionText: 'A Recurring Deposit requires you to:',
          options: [
            'Deposit a lump sum once',
            'Deposit a fixed amount every month',
            'Keep zero balance',
            'Make unlimited transactions'
          ],
          correctAnswerIndex: 1,
          explanation: 'RD requires regular monthly deposits of a fixed amount for a chosen period.',
        ),
      ],
    );
  }

  static LessonModel _savingLesson2() {
    return const LessonModel(
      lessonId: 'saving_02',
      categoryId: 'saving',
      title: 'Understanding Simple Interest',
      estimatedMinutes: 6,
      orderIndex: 1,
      content:
          '**Simple Interest** is calculated only on the original amount (principal) you deposit or borrow.\n\n'
          'Formula: **SI = P × R × T / 100**\n\n'
          'Where:\n'
          '• P = Principal (original amount)\n'
          '• R = Rate of interest per year (%)\n'
          '• T = Time in years\n\n'
          'Total Amount = P + SI\n\n'
          'Simple interest is straightforward – the interest stays the same each year because it\'s always calculated on the original principal.',
      example:
          'You deposit ₹10,000 in a bank at 5% simple interest for 3 years.\n'
          'SI = 10,000 × 5 × 3 / 100 = ₹1,500\n'
          'Total after 3 years = ₹10,000 + ₹1,500 = ₹11,500\n'
          'You earn ₹500 each year consistently.',
      questions: [
        QuestionModel(
          questionId: 's2_q1',
          questionText: 'Simple interest is calculated on:',
          options: ['Total amount', 'The interest earned', 'Only the principal amount', 'Monthly income'],
          correctAnswerIndex: 2,
          explanation: 'Simple interest is always calculated on the original principal amount only.',
        ),
        QuestionModel(
          questionId: 's2_q2',
          questionText: 'If P = ₹5,000, R = 10%, T = 2 years, what is the simple interest?',
          options: ['₹500', '₹1,000', '₹1,500', '₹2,000'],
          correctAnswerIndex: 1,
          explanation: 'SI = 5,000 × 10 × 2 / 100 = ₹1,000',
        ),
        QuestionModel(
          questionId: 's2_q3',
          questionText: 'With simple interest, the interest earned each year is:',
          options: ['Increasing', 'Decreasing', 'The same', 'Unpredictable'],
          correctAnswerIndex: 2,
          explanation: 'Since SI is calculated on the original principal, the interest stays constant each year.',
        ),
      ],
    );
  }

  static LessonModel _savingLesson3() {
    return const LessonModel(
      lessonId: 'saving_03',
      categoryId: 'saving',
      title: 'The Power of Compound Interest',
      estimatedMinutes: 7,
      orderIndex: 2,
      content:
          '**Compound Interest** is interest calculated on both the principal AND previously earned interest. This is often called "interest on interest."\n\n'
          'Formula: **A = P × (1 + R/100)^T**\n\n'
          'Where:\n'
          '• A = Final amount\n'
          '• P = Principal\n'
          '• R = Annual interest rate\n'
          '• T = Time in years\n\n'
          'Compound Interest = A - P\n\n'
          'Why is it powerful?\n'
          'Your money grows exponentially over time. The longer you save, the more dramatic the growth. '
          'Albert Einstein reportedly called compound interest the "eighth wonder of the world."',
      example:
          'Compare ₹10,000 at 10% for 5 years:\n\n'
          'Simple Interest: SI = 10,000 × 10 × 5 / 100 = ₹5,000 → Total: ₹15,000\n\n'
          'Compound Interest: A = 10,000 × (1.10)^5 = ₹16,105 → Interest: ₹6,105\n\n'
          'Compound interest earned ₹1,105 MORE! This difference grows dramatically with time and larger amounts.',
      questions: [
        QuestionModel(
          questionId: 's3_q1',
          questionText: 'Compound interest is calculated on:',
          options: [
            'Only the principal',
            'Only the interest',
            'Principal and accumulated interest',
            'Monthly salary'
          ],
          correctAnswerIndex: 2,
          explanation: 'Compound interest uses both the principal and previously earned interest for calculations.',
        ),
        QuestionModel(
          questionId: 's3_q2',
          questionText: 'Which earns more over time – simple or compound interest?',
          options: ['Simple Interest', 'Compound Interest', 'They are equal', 'Depends on the bank'],
          correctAnswerIndex: 1,
          explanation: 'Compound interest always earns more because interest itself earns interest.',
        ),
        QuestionModel(
          questionId: 's3_q3',
          questionText: 'What makes compound interest more powerful over time?',
          options: [
            'Lower tax rates',
            'Interest earning interest (exponential growth)',
            'Government subsidies',
            'Inflation'
          ],
          correctAnswerIndex: 1,
          explanation: 'The "interest on interest" effect creates exponential growth over time.',
        ),
        QuestionModel(
          questionId: 's3_q4',
          questionText: '₹10,000 at 10% compound interest for 2 years equals approximately:',
          options: ['₹11,000', '₹12,000', '₹12,100', '₹13,000'],
          correctAnswerIndex: 2,
          explanation: 'Year 1: 10,000 × 1.10 = 11,000. Year 2: 11,000 × 1.10 = 12,100.',
        ),
      ],
    );
  }

  static LessonModel _savingLesson4() {
    return const LessonModel(
      lessonId: 'saving_04',
      categoryId: 'saving',
      title: 'Savings Account vs Fixed Deposits',
      estimatedMinutes: 5,
      orderIndex: 3,
      content:
          'Both savings accounts and fixed deposits are safe ways to save, but they serve different purposes.\n\n'
          '**Savings Account:**\n'
          '• Interest: 3-7% per year\n'
          '• Access: Withdraw anytime\n'
          '• Best for: Daily expenses, emergency fund\n'
          '• Risk: Very low\n\n'
          '**Fixed Deposit (FD):**\n'
          '• Interest: 6-8% per year\n'
          '• Access: Locked for a fixed period\n'
          '• Best for: Money you won\'t need soon\n'
          '• Risk: Very low\n'
          '• Penalty: Early withdrawal fee\n\n'
          'Strategy: Keep 3-6 months expenses in savings account, put the rest in FDs for higher returns.',
      example:
          'Ankit has ₹1,00,000 saved.\n'
          '• He keeps ₹30,000 in savings account (4% interest) for emergencies = earns ₹1,200/year\n'
          '• He puts ₹70,000 in FD (7% interest) for 1 year = earns ₹4,900/year\n'
          '• Total interest earned: ₹6,100/year instead of just ₹4,000 if everything was in savings.',
      questions: [
        QuestionModel(
          questionId: 's4_q1',
          questionText: 'Which offers a higher interest rate?',
          options: ['Savings Account', 'Fixed Deposit', 'Both are same', 'Current Account'],
          correctAnswerIndex: 1,
          explanation: 'FDs offer higher interest because your money is locked for a fixed period.',
        ),
        QuestionModel(
          questionId: 's4_q2',
          questionText: 'What happens if you withdraw from an FD before maturity?',
          options: ['Nothing', 'You earn bonus interest', 'You pay a penalty', 'The bank refuses'],
          correctAnswerIndex: 2,
          explanation: 'Banks charge a penalty (reduced interest) for early FD withdrawal.',
        ),
        QuestionModel(
          questionId: 's4_q3',
          questionText: 'Emergency fund should be kept in a:',
          options: ['Fixed Deposit only', 'Savings Account', 'Stock market', 'Real estate'],
          correctAnswerIndex: 1,
          explanation: 'Savings accounts offer easy access, important for emergencies.',
        ),
      ],
    );
  }

  static LessonModel _savingLesson5() {
    return const LessonModel(
      lessonId: 'saving_05',
      categoryId: 'saving',
      title: 'Starting Your Saving Habit',
      estimatedMinutes: 5,
      orderIndex: 4,
      content:
          'Building a saving habit early is one of the best financial decisions you can make.\n\n'
          '**Pay Yourself First**: Before spending on anything else, set aside savings.\n\n'
          'Practical tips:\n'
          '1. **Start small** – Even ₹500/month is a great start\n'
          '2. **Automate it** – Set up auto-transfer on payday\n'
          '3. **Use the 24-hour rule** – Wait 24 hours before impulse purchases\n'
          '4. **Set specific goals** – "Save ₹50,000 for a laptop" is better than "save money"\n'
          '5. **Track progress** – Seeing growth motivates you to continue\n'
          '6. **Increase gradually** – Add ₹500 more each month when possible\n\n'
          'The magic of starting early: If you save ₹2,000/month from age 18 at 10% returns, '
          'you\'ll have over ₹1 crore by age 45!',
      example:
          'Meera, 17, started saving ₹1,000/month from her birthday money and part-time tutoring. '
          'She set a goal to buy a ₹15,000 tablet for college. She automated transfers and used the 24-hour rule '
          'to avoid impulse shopping. In 15 months, she bought her tablet and felt accomplished. '
          'Now at 18, she saves ₹2,000/month and has started a small FD.',
      questions: [
        QuestionModel(
          questionId: 's5_q1',
          questionText: 'What does "Pay Yourself First" mean?',
          options: [
            'Buy whatever you want first',
            'Set aside savings before spending',
            'Pay your bills first',
            'Get a high salary'
          ],
          correctAnswerIndex: 1,
          explanation: '"Pay Yourself First" means prioritizing savings by setting money aside before other expenses.',
        ),
        QuestionModel(
          questionId: 's5_q2',
          questionText: 'The 24-hour rule helps with:',
          options: ['Earning more money', 'Avoiding impulse purchases', 'Getting better interest', 'Paying rent'],
          correctAnswerIndex: 1,
          explanation: 'Waiting 24 hours before a purchase helps you decide if you truly need it.',
        ),
        QuestionModel(
          questionId: 's5_q3',
          questionText: 'Which saving goal is more effective?',
          options: [
            '"Save some money"',
            '"Save ₹30,000 for a trip by December"',
            '"Save everything"',
            '"Don\'t spend at all"'
          ],
          correctAnswerIndex: 1,
          explanation: 'Specific, measurable goals with deadlines are more motivating and trackable.',
        ),
      ],
    );
  }

  // ─── CATEGORY 3: INVESTING BASICS ─────────────────────────────────────

  static CategoryModel _investingCategory() {
    return CategoryModel(
      categoryId: 'investing',
      title: 'Investing Basics',
      description: 'Learn the fundamentals of investing and growing wealth.',
      icon: Icons.trending_up,
      themeColor: AppConstants.investingColor,
      orderIndex: 2,
      lessons: [
        _investingLesson1(),
        _investingLesson2(),
        _investingLesson3(),
        _investingLesson4(),
        _investingLesson5(),
      ],
    );
  }

  static LessonModel _investingLesson1() {
    return const LessonModel(
      lessonId: 'investing_01',
      categoryId: 'investing',
      title: 'What is Investing?',
      estimatedMinutes: 5,
      orderIndex: 0,
      content:
          '**Investing** means putting your money into something with the expectation that it will grow over time.\n\n'
          'Saving vs Investing:\n'
          '• **Saving**: Keeping money safe (low risk, low return)\n'
          '• **Investing**: Growing money (higher risk, higher potential return)\n\n'
          'Common investment options:\n'
          '1. **Stocks** – Buy ownership in companies\n'
          '2. **Mutual Funds** – Pool money with other investors\n'
          '3. **Fixed Deposits** – Safe, guaranteed returns\n'
          '4. **Gold** – Traditional store of value\n'
          '5. **Real Estate** – Property investment\n\n'
          'Key principle: **Start early, stay consistent.** Time in the market beats timing the market.',
      example:
          'Imagine you have ₹10,000. If you keep it under your mattress, in 10 years it\'s still ₹10,000 '
          '(but buys less due to inflation). If you invest in a mutual fund earning 12% average returns, '
          'it becomes ₹31,058 in 10 years. That\'s over 3x your money!',
      questions: [
        QuestionModel(
          questionId: 'i1_q1',
          questionText: 'What is the main purpose of investing?',
          options: ['To spend money', 'To grow money over time', 'To pay bills', 'To get a job'],
          correctAnswerIndex: 1,
          explanation: 'Investing aims to grow your money over time through various financial instruments.',
        ),
        QuestionModel(
          questionId: 'i1_q2',
          questionText: 'How is investing different from saving?',
          options: [
            'They are the same',
            'Investing has higher risk and potential return',
            'Saving has higher returns',
            'Investing is only for rich people'
          ],
          correctAnswerIndex: 1,
          explanation: 'Investing involves higher risk but offers higher potential returns compared to saving.',
        ),
        QuestionModel(
          questionId: 'i1_q3',
          questionText: 'Which phrase best describes a good investment strategy?',
          options: [
            'Time the market perfectly',
            'Invest only when stocks are low',
            'Start early, stay consistent',
            'Wait until you\'re wealthy'
          ],
          correctAnswerIndex: 2,
          explanation: 'Starting early and staying consistent allows compound growth to work in your favor.',
        ),
      ],
    );
  }

  static LessonModel _investingLesson2() {
    return const LessonModel(
      lessonId: 'investing_02',
      categoryId: 'investing',
      title: 'Stocks and Shares Explained',
      estimatedMinutes: 6,
      orderIndex: 1,
      content:
          'A **stock** (or share) represents a small piece of ownership in a company.\n\n'
          'When you buy a stock, you become a **shareholder** – a part-owner of that company.\n\n'
          'How stocks make money:\n'
          '1. **Price appreciation**: Buy low, sell high\n'
          '2. **Dividends**: Some companies share profits with shareholders\n\n'
          'Key terms:\n'
          '• **Stock Exchange**: Market where stocks are bought/sold (BSE, NSE in India)\n'
          '• **Market Price**: Current price of a stock\n'
          '• **Bull Market**: Prices are rising\n'
          '• **Bear Market**: Prices are falling\n'
          '• **Portfolio**: Collection of all your investments\n\n'
          'Important: Stock prices go up AND down. Never invest money you can\'t afford to lose.',
      example:
          'You buy 10 shares of a company at ₹100 each (total ₹1,000). After a year, each share is worth ₹150. '
          'Your investment is now ₹1,500 – a ₹500 profit (50% return!). But if the price drops to ₹80, '
          'your investment is worth ₹800 – a ₹200 loss. This is why understanding risk is important.',
      questions: [
        QuestionModel(
          questionId: 'i2_q1',
          questionText: 'What does owning a stock mean?',
          options: [
            'You owe money to the company',
            'You own a small part of the company',
            'You work for the company',
            'You lent money to the company'
          ],
          correctAnswerIndex: 1,
          explanation: 'A stock represents partial ownership in a company.',
        ),
        QuestionModel(
          questionId: 'i2_q2',
          questionText: 'What is a "bull market"?',
          options: [
            'Market for agricultural products',
            'Market where prices are falling',
            'Market where prices are rising',
            'A market in Spain'
          ],
          correctAnswerIndex: 2,
          explanation: 'A bull market refers to a period of rising stock prices and investor optimism.',
        ),
        QuestionModel(
          questionId: 'i2_q3',
          questionText: 'Dividends are:',
          options: [
            'Fees you pay to buy stocks',
            'Profits shared with shareholders',
            'Taxes on investments',
            'Losses from investing'
          ],
          correctAnswerIndex: 1,
          explanation: 'Dividends are a portion of a company\'s profits distributed to shareholders.',
        ),
      ],
    );
  }

  static LessonModel _investingLesson3() {
    return const LessonModel(
      lessonId: 'investing_03',
      categoryId: 'investing',
      title: 'Risk vs Return',
      estimatedMinutes: 5,
      orderIndex: 2,
      content:
          'In investing, **risk** and **return** are directly related – higher potential returns come with higher risk.\n\n'
          'Risk Levels:\n\n'
          '**Low Risk, Low Return:**\n'
          '• Fixed Deposits (6-8%)\n'
          '• Government Bonds (7-8%)\n'
          '• Savings Accounts (3-7%)\n\n'
          '**Medium Risk, Medium Return:**\n'
          '• Mutual Funds (10-15%)\n'
          '• Gold (8-12%)\n\n'
          '**High Risk, High Return:**\n'
          '• Individual Stocks (variable, can be 20%+ or negative)\n'
          '• Cryptocurrency (extremely volatile)\n\n'
          'Your **risk tolerance** depends on:\n'
          '• Age (younger = can take more risk)\n'
          '• Financial goals\n'
          '• Time horizon\n'
          '• Emotional comfort with losses',
      example:
          'Arjun (20 years old) and his father (50 years old) both have ₹1,00,000 to invest. '
          'Arjun invests 70% in stocks and 30% in FDs because he has 30+ years before retirement. '
          'His father invests 30% in stocks and 70% in bonds/FDs because he needs capital safety. '
          'Both are making smart choices based on their risk tolerance and time horizon.',
      questions: [
        QuestionModel(
          questionId: 'i3_q1',
          questionText: 'Higher potential returns usually come with:',
          options: ['Lower risk', 'Higher risk', 'No risk', 'Guaranteed profits'],
          correctAnswerIndex: 1,
          explanation: 'In investing, higher potential returns are always associated with higher risk.',
        ),
        QuestionModel(
          questionId: 'i3_q2',
          questionText: 'Which is the LOWEST risk investment?',
          options: ['Individual stocks', 'Cryptocurrency', 'Fixed Deposits', 'Startup equity'],
          correctAnswerIndex: 2,
          explanation: 'Fixed deposits are among the safest investments with guaranteed returns.',
        ),
        QuestionModel(
          questionId: 'i3_q3',
          questionText: 'A young investor (age 20) can generally afford to:',
          options: [
            'Take only safe investments',
            'Take higher risks due to longer time horizon',
            'Avoid investing completely',
            'Only invest in gold'
          ],
          correctAnswerIndex: 1,
          explanation: 'Young investors have more time to recover from market downturns, allowing higher risk tolerance.',
        ),
      ],
    );
  }

  static LessonModel _investingLesson4() {
    return const LessonModel(
      lessonId: 'investing_04',
      categoryId: 'investing',
      title: 'Diversification Strategy',
      estimatedMinutes: 5,
      orderIndex: 3,
      content:
          '**Diversification** means spreading your investments across different types to reduce risk.\n\n'
          'The idea: "Don\'t put all your eggs in one basket."\n\n'
          'Types of diversification:\n'
          '1. **Asset class**: Mix stocks, bonds, FDs, gold\n'
          '2. **Sector**: Invest in different industries (tech, healthcare, banking)\n'
          '3. **Geography**: Invest in domestic and international markets\n\n'
          'Why diversify?\n'
          '• If one investment falls, others may rise\n'
          '• Reduces overall portfolio risk\n'
          '• Smoother, more consistent returns\n\n'
          'How to diversify easily:\n'
          '• **Mutual Funds** – Built-in diversification\n'
          '• **Index Funds** – Own a piece of the entire market\n'
          '• **SIP (Systematic Investment Plan)** – Invest monthly in mutual funds',
      example:
          'Ravi put all ₹50,000 in one tech company stock. When tech crashed, he lost 40% (₹20,000 loss). '
          'His friend Kiran split ₹50,000: ₹15,000 in tech stocks, ₹15,000 in gold, ₹20,000 in an FD. '
          'When tech crashed, Kiran\'s tech stocks lost 40% (₹6,000), but gold went up 10% (₹1,500 gain) '
          'and FD earned ₹1,400. Kiran\'s net loss was only ₹3,100 vs Ravi\'s ₹20,000.',
      questions: [
        QuestionModel(
          questionId: 'i4_q1',
          questionText: 'What does diversification mean in investing?',
          options: [
            'Investing all money in one stock',
            'Spreading investments across different types',
            'Only investing in FDs',
            'Investing in one sector only'
          ],
          correctAnswerIndex: 1,
          explanation: 'Diversification means spreading investments to reduce risk.',
        ),
        QuestionModel(
          questionId: 'i4_q2',
          questionText: '"Don\'t put all your eggs in one basket" relates to:',
          options: ['Saving more', 'Diversification', 'Budgeting', 'Taking more risk'],
          correctAnswerIndex: 1,
          explanation: 'This saying perfectly captures the concept of diversification – spread out to reduce risk.',
        ),
        QuestionModel(
          questionId: 'i4_q3',
          questionText: 'Which investment provides built-in diversification?',
          options: ['Individual stocks', 'Cryptocurrency', 'Mutual Funds', 'A single company\'s bonds'],
          correctAnswerIndex: 2,
          explanation: 'Mutual funds pool money to buy many different securities, providing built-in diversification.',
        ),
      ],
    );
  }

  static LessonModel _investingLesson5() {
    return const LessonModel(
      lessonId: 'investing_05',
      categoryId: 'investing',
      title: 'Starting Small with Investing',
      estimatedMinutes: 5,
      orderIndex: 4,
      content:
          'You don\'t need a lot of money to start investing. Many options are available for beginners.\n\n'
          'How to start small:\n\n'
          '1. **SIP (Systematic Investment Plan)**\n'
          '   • Invest as little as ₹500/month in mutual funds\n'
          '   • Automatic monthly deduction\n'
          '   • Reduces market timing risk\n\n'
          '2. **Digital Gold**\n'
          '   • Buy gold starting from ₹1\n'
          '   • Available on many apps\n\n'
          '3. **Government Small Savings**\n'
          '   • PPF (Public Provident Fund)\n'
          '   • NSC (National Savings Certificate)\n\n'
          'Steps to start:\n'
          '1. Build an emergency fund first\n'
          '2. Learn the basics (you\'re doing this!)\n'
          '3. Open a demat account\n'
          '4. Start with SIP in index funds\n'
          '5. Stay invested for the long term',
      example:
          'Divya started a SIP of ₹1,000/month in a Nifty 50 index fund at age 18. By investing just ₹12,000/year '
          'at an average return of 12%, here\'s what she could have:\n'
          '• After 5 years: ₹82,486\n'
          '• After 10 years: ₹2,32,339\n'
          '• After 20 years: ₹9,89,255\n'
          '• After 30 years: ₹34,94,964\n'
          'Starting small and early made her nearly ₹35 lakhs from just ₹1,000/month!',
      questions: [
        QuestionModel(
          questionId: 'i5_q1',
          questionText: 'What is a SIP?',
          options: [
            'A type of bank account',
            'Systematic Investment Plan – regular monthly investment',
            'A type of insurance',
            'A government tax'
          ],
          correctAnswerIndex: 1,
          explanation: 'SIP stands for Systematic Investment Plan – investing a fixed amount regularly in mutual funds.',
        ),
        QuestionModel(
          questionId: 'i5_q2',
          questionText: 'What should you do BEFORE starting to invest?',
          options: [
            'Buy expensive things',
            'Build an emergency fund',
            'Take a loan',
            'Quit your job'
          ],
          correctAnswerIndex: 1,
          explanation: 'An emergency fund should be established first to cover unexpected expenses.',
        ),
        QuestionModel(
          questionId: 'i5_q3',
          questionText: 'How little can you start investing with SIP?',
          options: ['₹50,000', '₹10,000', '₹5,000', '₹500'],
          correctAnswerIndex: 3,
          explanation: 'Many mutual funds allow SIP investments starting from just ₹500/month.',
        ),
      ],
    );
  }

  // ─── CATEGORY 4: CREDIT & DEBT ────────────────────────────────────────

  static CategoryModel _creditCategory() {
    return CategoryModel(
      categoryId: 'credit',
      title: 'Credit & Debt',
      description: 'Understand credit, loans, and how to use debt wisely.',
      icon: Icons.credit_card,
      themeColor: AppConstants.creditColor,
      orderIndex: 3,
      lessons: [
        _creditLesson1(),
        _creditLesson2(),
        _creditLesson3(),
        _creditLesson4(),
        _creditLesson5(),
      ],
    );
  }

  static LessonModel _creditLesson1() {
    return const LessonModel(
      lessonId: 'credit_01',
      categoryId: 'credit',
      title: 'What is Credit?',
      estimatedMinutes: 5,
      orderIndex: 0,
      content:
          '**Credit** is the ability to borrow money with the promise to pay it back later, usually with interest.\n\n'
          'Types of credit:\n\n'
          '1. **Credit Cards**: Borrow up to a limit for purchases, pay back monthly\n'
          '2. **Personal Loans**: Borrow a fixed amount, repay in installments\n'
          '3. **Education Loans**: Specifically for educational expenses\n'
          '4. **Home Loans**: For buying property (long-term, 15-30 years)\n\n'
          'Key concepts:\n'
          '• **Principal**: Amount borrowed\n'
          '• **Interest**: Cost of borrowing (percentage)\n'
          '• **EMI**: Equated Monthly Installment (fixed monthly payment)\n'
          '• **Tenure**: Duration of the loan\n\n'
          'Remember: Credit is a tool – it can be helpful or harmful depending on how you use it.',
      example:
          'Pooja uses a credit card with a ₹50,000 limit. She buys groceries (₹3,000) and a train ticket (₹2,000) '
          'totalling ₹5,000. She pays the full ₹5,000 before the due date and pays zero interest. '
          'Her friend Raj spends ₹30,000 on his credit card but only pays the minimum (₹1,500). '
          'He gets charged 36% annual interest on the remaining ₹28,500!',
      questions: [
        QuestionModel(
          questionId: 'c1_q1',
          questionText: 'What is credit?',
          options: [
            'Free money from the bank',
            'Ability to borrow money and repay later',
            'Money you have in savings',
            'A type of investment'
          ],
          correctAnswerIndex: 1,
          explanation: 'Credit is borrowed money that must be repaid, usually with interest.',
        ),
        QuestionModel(
          questionId: 'c1_q2',
          questionText: 'What does EMI stand for?',
          options: [
            'Extra Monthly Income',
            'Equated Monthly Installment',
            'Electronic Money Interface',
            'Essential Minimum Investment'
          ],
          correctAnswerIndex: 1,
          explanation: 'EMI = Equated Monthly Installment – the fixed amount you pay each month on a loan.',
        ),
        QuestionModel(
          questionId: 'c1_q3',
          questionText: 'What happens when you pay only the minimum on a credit card?',
          options: [
            'Nothing, it\'s fine',
            'You earn rewards',
            'You get charged high interest on the remaining balance',
            'Your credit limit increases'
          ],
          correctAnswerIndex: 2,
          explanation: 'Paying only the minimum means you pay high interest (24-40%) on the unpaid balance.',
        ),
      ],
    );
  }

  static LessonModel _creditLesson2() {
    return const LessonModel(
      lessonId: 'credit_02',
      categoryId: 'credit',
      title: 'Understanding Credit Scores',
      estimatedMinutes: 6,
      orderIndex: 1,
      content:
          'A **credit score** is a number (300-900) that shows how trustworthy you are with borrowed money.\n\n'
          'Score ranges:\n'
          '• **750-900**: Excellent – Best loan terms\n'
          '• **700-749**: Good – Most loans approved\n'
          '• **650-699**: Fair – Higher interest rates\n'
          '• **Below 650**: Poor – Difficult to get loans\n\n'
          'What affects your credit score:\n'
          '1. **Payment history (35%)**: Pay on time, every time\n'
          '2. **Credit utilization (30%)**: Use less than 30% of your credit limit\n'
          '3. **Credit history length (15%)**: Longer history is better\n'
          '4. **Credit mix (10%)**: Different types of credit\n'
          '5. **New credit inquiries (10%)**: Don\'t apply for too many at once\n\n'
          'In India, CIBIL score is the most commonly used credit score.',
      example:
          'Two friends apply for a car loan of ₹5,00,000:\n'
          '• Sneha (CIBIL score: 780): Gets 8.5% interest = EMI ₹10,276 for 5 years = Total: ₹6,16,560\n'
          '• Rohan (CIBIL score: 620): Gets 12% interest = EMI ₹11,122 for 5 years = Total: ₹6,67,320\n'
          'Sneha saves ₹50,760 over the loan tenure just because of a better credit score!',
      questions: [
        QuestionModel(
          questionId: 'c2_q1',
          questionText: 'What is a good CIBIL score in India?',
          options: ['100-300', '300-500', '500-650', '750-900'],
          correctAnswerIndex: 3,
          explanation: 'A CIBIL score of 750-900 is considered excellent and gets you the best loan terms.',
        ),
        QuestionModel(
          questionId: 'c2_q2',
          questionText: 'What has the biggest impact on your credit score?',
          options: ['Your salary', 'Payment history', 'Your age', 'How many bank accounts you have'],
          correctAnswerIndex: 1,
          explanation: 'Payment history (paying on time) accounts for 35% of your credit score.',
        ),
        QuestionModel(
          questionId: 'c2_q3',
          questionText: 'What percentage of your credit limit should you ideally use?',
          options: ['100%', 'Less than 30%', '50-70%', 'Over 90%'],
          correctAnswerIndex: 1,
          explanation: 'Keeping credit utilization below 30% is recommended for a healthy credit score.',
        ),
      ],
    );
  }

  static LessonModel _creditLesson3() {
    return const LessonModel(
      lessonId: 'credit_03',
      categoryId: 'credit',
      title: 'Good Debt vs Bad Debt',
      estimatedMinutes: 5,
      orderIndex: 2,
      content:
          'Not all debt is equal. Some debt helps you build wealth, while other debt destroys it.\n\n'
          '**Good Debt** – Debt that helps you earn more or build value:\n'
          '• Education loan (increases earning potential)\n'
          '• Home loan (property appreciates in value)\n'
          '• Business loan (generates income)\n\n'
          '**Bad Debt** – Debt for things that lose value or don\'t earn you money:\n'
          '• Credit card debt for shopping sprees\n'
          '• Personal loan for a vacation\n'
          '• Car loan for an expensive car you can\'t afford\n'
          '• Borrowing for gambling\n\n'
          'The golden rule: If debt puts money in your pocket (directly or indirectly), it might be good debt. '
          'If it only takes money out, it\'s bad debt.',
      example:
          'Kavya takes an education loan of ₹8,00,000 at 8% interest for an MBA. After graduating, her salary '
          'increases from ₹4,00,000 to ₹12,00,000/year. The loan cost her ₹9,60,000 total, but her salary '
          'increased by ₹8,00,000/year – this is good debt.\n\n'
          'Her brother takes a personal loan of ₹2,00,000 at 14% to buy the latest smartphone and designer '
          'clothes. These items lose value immediately and don\'t generate income – this is bad debt.',
      questions: [
        QuestionModel(
          questionId: 'c3_q1',
          questionText: 'Which is an example of "good debt"?',
          options: ['Credit card shopping spree', 'Education loan', 'Personal loan for vacation', 'Payday loan'],
          correctAnswerIndex: 1,
          explanation: 'Education loans are considered good debt as they increase your earning potential.',
        ),
        QuestionModel(
          questionId: 'c3_q2',
          questionText: 'The golden rule for debt is:',
          options: [
            'All debt is bad',
            'Borrow as much as possible',
            'Good debt puts money in your pocket',
            'Never take any loan'
          ],
          correctAnswerIndex: 2,
          explanation: 'Good debt helps you earn more or build value over time.',
        ),
        QuestionModel(
          questionId: 'c3_q3',
          questionText: 'Taking a personal loan for a luxury vacation is:',
          options: ['Good debt', 'Bad debt', 'Neither', 'An investment'],
          correctAnswerIndex: 1,
          explanation: 'A vacation doesn\'t generate income or appreciate in value – this is bad debt.',
        ),
      ],
    );
  }

  static LessonModel _creditLesson4() {
    return const LessonModel(
      lessonId: 'credit_04',
      categoryId: 'credit',
      title: 'How Loans Work',
      estimatedMinutes: 6,
      orderIndex: 3,
      content:
          'A **loan** is a sum of money borrowed that must be repaid with interest over a set period.\n\n'
          'Key components:\n'
          '• **Principal**: The amount borrowed\n'
          '• **Interest Rate**: The cost of borrowing (annual %)\n'
          '• **Tenure**: Duration of the loan\n'
          '• **EMI**: Monthly payment amount\n'
          '• **Collateral**: Asset pledged as security (for secured loans)\n\n'
          'Types of loans:\n'
          '1. **Secured**: Backed by collateral (home loan, car loan) – lower interest\n'
          '2. **Unsecured**: No collateral needed (personal loan, credit card) – higher interest\n\n'
          'How EMI works:\n'
          'Each EMI payment includes both principal repayment and interest. Early EMIs have more interest; '
          'later EMIs have more principal repayment.\n\n'
          'Before taking a loan, always:\n'
          '• Compare interest rates from multiple banks\n'
          '• Check for hidden charges\n'
          '• Ensure EMI is less than 40% of income',
      example:
          'Suresh takes a home loan:\n'
          '• Principal: ₹30,00,000\n'
          '• Interest: 8.5% per year\n'
          '• Tenure: 20 years\n'
          '• EMI: ₹26,035\n'
          '• Total repayment: ₹62,48,400 (He pays ₹32,48,400 as interest!)\n\n'
          'If he chose 15 years instead: EMI = ₹29,542 but Total = ₹53,17,560 (saves ₹9,30,840 in interest!).',
      questions: [
        QuestionModel(
          questionId: 'c4_q1',
          questionText: 'Which type of loan typically has a LOWER interest rate?',
          options: ['Unsecured loan', 'Credit card loan', 'Secured loan', 'Payday loan'],
          correctAnswerIndex: 2,
          explanation: 'Secured loans have collateral, reducing the lender\'s risk, so interest rates are lower.',
        ),
        QuestionModel(
          questionId: 'c4_q2',
          questionText: 'Your EMI should ideally be less than what % of your income?',
          options: ['10%', '25%', '40%', '80%'],
          correctAnswerIndex: 2,
          explanation: 'Financial advisors recommend keeping total EMIs below 40% of monthly income.',
        ),
        QuestionModel(
          questionId: 'c4_q3',
          questionText: 'A shorter loan tenure means:',
          options: [
            'Higher EMI but less total interest paid',
            'Lower EMI and more interest paid',
            'No difference in total cost',
            'The bank charges penalty'
          ],
          correctAnswerIndex: 0,
          explanation: 'Shorter tenure means higher monthly payments but significantly less total interest over the life of the loan.',
        ),
      ],
    );
  }

  static LessonModel _creditLesson5() {
    return const LessonModel(
      lessonId: 'credit_05',
      categoryId: 'credit',
      title: 'Avoiding Debt Traps',
      estimatedMinutes: 5,
      orderIndex: 4,
      content:
          'A **debt trap** occurs when you borrow money to pay off existing debt, creating a cycle of increasing debt.\n\n'
          'Common debt traps:\n\n'
          '1. **Credit card minimum payments**: Only paying minimum keeps you in debt for years\n'
          '2. **Payday loans**: Very high interest short-term loans\n'
          '3. **Lifestyle inflation**: Spending more as you earn more, borrowing to maintain lifestyle\n'
          '4. **EMI culture**: Taking multiple EMIs that exceed 40% of income\n'
          '5. **Borrowing to invest**: Extremely risky – never do this\n\n'
          'How to avoid debt traps:\n'
          '• Live within your means\n'
          '• Pay credit card bills in full\n'
          '• Build an emergency fund\n'
          '• Avoid impulse borrowing\n'
          '• Use the debt avalanche method (pay highest interest first)\n'
          '• Seek help early if you\'re struggling',
      example:
          'Deepak had 3 credit cards with total debt of ₹2,00,000 at 36% interest. Paying only minimums, '
          'he\'d take 20+ years to clear the debt and pay over ₹5,00,000 in interest alone! '
          'He used the debt avalanche method: paid off the highest interest card first while paying minimums on others. '
          'He also took a personal loan at 12% to clear the credit card debt. He went from 36% interest to 12% '
          'and became debt-free in 3 years.',
      questions: [
        QuestionModel(
          questionId: 'c5_q1',
          questionText: 'What is a debt trap?',
          options: [
            'A type of investment',
            'A cycle of borrowing to pay off existing debt',
            'A savings strategy',
            'A type of bank account'
          ],
          correctAnswerIndex: 1,
          explanation: 'A debt trap is when you keep borrowing to pay off existing debts, creating an endless cycle.',
        ),
        QuestionModel(
          questionId: 'c5_q2',
          questionText: 'The debt avalanche method means:',
          options: [
            'Taking more loans',
            'Paying off the highest interest debt first',
            'Ignoring all debts',
            'Paying all debts equally'
          ],
          correctAnswerIndex: 1,
          explanation: 'The debt avalanche method focuses on paying off the highest interest rate debt first to save money.',
        ),
        QuestionModel(
          questionId: 'c5_q3',
          questionText: 'Which is NOT a good strategy to avoid debt traps?',
          options: [
            'Pay credit card bills in full',
            'Build an emergency fund',
            'Take payday loans when short on cash',
            'Live within your means'
          ],
          correctAnswerIndex: 2,
          explanation: 'Payday loans are one of the worst debt traps due to extremely high interest rates.',
        ),
      ],
    );
  }
}
