//TODO: Add a bloomValue storage variable of 2!!

let module_2 = [
    {
        question: 'Which type is valid in the following code snippet?',
        base: '? result = value;',
        ctx: () => shuffle([
            ['boolean', Math.random() > 0.5 ? 'true' : 'false'],
            ['int', randI(-1000, 1000)],
            ['double', (Math.random() * 1000).toFixed(2)],
            ['char', `'${String.fromCharCode(randI(65, 75))}'`]
        ])[0],
        ans: ctx => ctx[0],
        vars: [
            ['value', ctx => ctx[1]]
        ]
    }
];

let modules = [
    [],
    [],
    module_2,
];

shuffle(module_2);

function getQuestion(module) {
    let q = modules[module].pop();
    modules[module].unshift(q);
    let question = generate(q);
    question.module = module;
    return JSON.stringify(question);
};

let evalfy = code => eval(
    `let output = [];
let System = {out: {print: v => output.push(v), println: v => output.push(v + '\\n')}};
${code}
output.join("");`);

let replacements = [
    [/int /g, 'let '],
];

let templates = [
    {
        base:
`for (int index = start; index < end; index++) {
  System.out.print(index + ", ");
}`,
        vars: [
            ['start', () => getRandomInt(0, 3)],
            ['end', () => getRandomInt(4, 6)],
        ]
    }
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
    let ctx = template.ctx();
    let question = execReplace(template, ctx);
    let answers = [template.ans ? template.ans(ctx) : evalfy(question)];

    if (onlyResult)
        return answers[0];
    else
        return { question, answers };
};

function execReplace({ base, vars }, ctx) {
    let result = base;
    replacements.forEach(pair => result = result.replace(...pair));
    vars.forEach(pair => result = result.replace(pair[0], pair[1](ctx)));
    return result;
};

function randI(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
};

function shuffle(a) {
    for (let i = a.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [a[i], a[j]] = [a[j], a[i]];
    }
    return a;
};
