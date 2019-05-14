let question = 'What will this code snippet output?';

let templates = [

];

let module_2 = [
    {
        question: 'Which type is the best match?',
        base: '? result = _value;',
        ctx: () => pickOne([
            ['boolean', Math.random() > 0.5 ? 'true' : 'false'],
            ['int', randI(-1000, 1000)],
            ['double', (Math.random() * 1000).toFixed(2)],
            ['char', `'${String.fromCharCode(randI(65, 75))}'`]
        ]),
        ans: ctx => ctx[0],
        vars: [
            ['_value', ctx => ctx[1]]
        ]
    }
];

let module_3 = [
    {
        question,
        base: `int count = _rand;

if (count < 1) {
    System.out.print("Hmm, how do these work again?");
}
else if (count > 2) {
    System.out.print("Might be prime.");
}
else if (count == 1) {
    System.out.print("Why isn't one prime?");
}
else {
    System.out.print("The smallest prime.");
}`,
        ctx: () => pickOne([
            ['Hmm, how do these work again?', 0],
            ['Might be prime.', randI(3, 20)],
            ['Why isn\'t one prime?', 1],
            ['The smallest prime.', 2],
        ]),
        ans: ctx => ctx[0],
        vars: [
            ['_rand', ctx => ctx[1]]
        ]
    },
    {
        question,
        base: `String test = ".";

while (test.length() < _len)
    test = test + ".";

System.out.print(test);`,
        vars: [
            ['_len', () => randI(1, 5)]
        ]
    },
    {
        question,
        base:
`for (int index = _start; index < _end; index++) {
  System.out.print(index + ", ");
}`,
        vars: [
            ['_start', () => randI(0, 3)],
            ['_end', () => randI(4, 6)],
        ]
    },
    {
        question,
        base: `int count = _start;

while (true) {
    System.out.print(_expr + " ");

    if (count > _end)
        break;
}`,
        vars: [
            ['_expr', () => Math.random() < 0.5 ? 'count++' : '++count'],
            ['_start', () => randI(0, 1)],
            ['_end', () => randI(3, 4)]
        ]
    },
    {
        question,
        base: `try {
    _type value = _val;
    System.out.print(value * 2);
}
catch (Exception e) {
    System.out.print("Oops...");
}`,
        ctx: () => {
            let rand = randI(0, 3);
            return pickOne([
                ['Oops...', 'Integer', 'null'],
                [rand * 2, 'Integer', rand],
                ['Compile error', 'String', 'null']
            ])
        },
        ans: ctx => ctx[0],
        vars: [
            ['_type', ctx => ctx[1]],
            ['_val', ctx => ctx[2]]
        ]
    },
    {
        question,
        base: `try {
    throw new _err;
}
catch (IllegalStateException e) {
    System.out.print("I am the Law!");
}
catch (RuntimeException e) {
    System.out.print("Why are you running?");
}
catch (Exception e) {
    System.out.print("No exceptions!");
}
catch (Throwable e) {
    System.out.print("Hey, I caught it.");
}`,
        ctx: () => pickOne([
            ['IllegalStateException("This ain\'t Colorado!")', 'I am the Law!'],
            ['RuntimeException("You tripped.")', 'Why are you running?'],
            ['Exception("I need a drink.")', 'No exceptions!'],
            ['Throwable("Fastball!")', 'Hey, I caught it.']
        ]),
        ans: ctx => ctx[1],
        vars: [
            ['_err', ctx => ctx[0]]
        ]
    },
    {
        question,
        base: `int count = _count;
switch (count) {
    case 1:
        System.out.print("1 ");
        _break
    case 2:
        System.out.print("2 ");
        _break
    case 3:
        System.out.print("3 ");
        _break
    case 4:
        System.out.print("4 ");
        _break
}`,
        vars: [
            ['_count', () => randI(1, 4)],
            [/_break/g, () => () => Math.random() < 0.5 ? 'break;' : '']
        ]
    },
    {
        question,
        base: `int score = _score;

do {
    System.out.print("try ");
    score += 1;
} while (score % 5 != 0);

System.out.print("again");`,
        vars: [
            ['_score', () => randI(0, 4)]
        ]
    },
    {
        question,
        base: `for (int mario = _mStart; mario < _mEnd; mario++) {
    for (int luigi = _lStart; luigi < _lEnd; luigi++) {
        if (mario == luigi) {
            System.out.print("-");
        }
        else {
            System.out.print("|");
        }
    }
}`,
        ctx: () => [
            randI(-2, 2),
            randI(-2, 2)
        ],
        vars: [
            ['_mStart', ctx => ctx[0]],
            ['_mEnd', ctx => ctx[0] + 3],
            ['_lStart', ctx => ctx[1]],
            ['_lEnd', ctx => ctx[1] + 3],
        ]
    }
]

let modules = [
    templates,
    [],
    module_2,
    module_3
];

modules.forEach(module => shuffle(module));

function getQuestion (module) {
    if (module >= modules.length || modules[module].length === 0)
        return undefined;

    let q = modules[module].pop();
    modules[module].unshift(q);
    let question = generate(q);
    question.answers = question.answers.map(val => val + '')
    question.module = module;
    question.bloomValue = 2
    return JSON.stringify(question);
}

let evalfy = code => eval(
    `let output = [];
let System = {out: {print: v => output.push(v), println: v => output.push(v + '\\n')}};
${code}
output.join("");`);

let replacements = [
    [/int /g, 'let '],
    [/String /g, 'let '],
    [/\.length\(\) /g, '.length']
];

function generate(template) {
    let result = processTemplate(template, false);

    for (let i = 0; i < 3; i++) {
        let attempt;

        do {
            attempt = processTemplate(template);
        } while (result.answers.includes(attempt));

        result.answers.push(attempt);
    }

    result.question = template.question + '\n' + result.question;
    return result;
};

function processTemplate(template, onlyResult = true) {
    let ctx = template.ctx ? template.ctx() : {};
    let question = execReplace(template, ctx);
    let answers = [template.ans ? template.ans(ctx) : evalfy(js(question))];

    if (onlyResult)
        return answers[0];
    else
        return { question, answers };
};

function js(question) {
    replacements.forEach(pair => question = question.replace(...pair));
    return question;
}

function execReplace({ base, vars }, ctx) {
    let result = base;
    vars.forEach(pair => result = result.replace(pair[0], pair[1](ctx)));
    return result;
};

function randI(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
};

function shuffle(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
};

function pickOne(array) {
    return array[Math.floor(Math.random()*array.length)];
}
