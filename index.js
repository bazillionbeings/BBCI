'use strict';

let app = require('express')(),
    shell = require('shelljs');

app.get('/', (req, res) => {
    shell.exec('./pull-create.sh testDocker ayeressian/testdocker https://github.com/bazillionbeings/testdocker.git');
    res.end();
});

app.listen(4333);
