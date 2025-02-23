/* global hexo */

'use strict';

const fs = require('fs');
const p = require('path');
const { spawn } = require('child_process');

async function spawnAsync(cmd, args) {
    return new Promise((resolve, reject) => {
        const child = spawn(cmd, args);
        let s = "";
        child.stdout.on('data', data => {
            s += data;
        });

        child.stderr.on('data', data => {
            console.error(`stderr: ${data}`);
        });

        child.on('error', error => {
            console.error(`error: ${error.message}`);
            reject(error);
        });

        child.on('close', code => {
            if (code) {
                console.log(`child process exited with code ${code}`);
            }
            resolve(s);
        });
    });
}

async function renderMeta(data, options) {
    const path = data.path.slice(0, -1);
    const html = await spawnAsync("typst", [
        'c',
        '-f',
        'html',
        '--features',
        'html',
        // '--input',
        // `options='${JSON.stringify(options)}'`,
        '--root',
        p.parse(path).root,
        path,
        '-',
    ]);
    let start = html.search("<body>") + "<body>".length;
    let end = html.lastIndexOf("</body>");
    return html.slice(start, end).trim();
}

async function renderTypst(data, options) {
    const path = data.path;
    return await spawnAsync("typst", [
        'c',
        '-f',
        'html',
        '--features',
        'html',
        // '--input',
        // `options='${JSON.stringify(options)}'`,
        '--root',
        p.parse(path).root,
        path,
        '-',
    ]);
}

renderMeta.disableNunjucks = true;
renderTypst.disableNunjucks = true;

hexo.extend.renderer.register('typm', 'html', renderMeta);
hexo.extend.renderer.register('typst', 'html', renderTypst);