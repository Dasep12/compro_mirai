import { readdirSync, statSync, readFileSync, writeFileSync } from 'fs';
import { join } from 'path';

function walk(dir) {
  let results = [];
  const list = readdirSync(dir);
  list.forEach(function(file) {
    file = join(dir, file);
    const stat = statSync(file);
    if (stat && stat.isDirectory()) {
      results = results.concat(walk(file));
    } else {
      if (file.endsWith('.tsx') || file.endsWith('.ts')) {
        results.push(file);
      }
    }
  });
  return results;
}

const files = walk('./src');
let changedCount = 0;

files.forEach(file => {
  const content = readFileSync(file, 'utf8');
  const newContent = content.replace(/import\s+Image\s+from\s+["']next\/image["'];?/g, 'import Image from "@/components/ui/Image";');
  
  if (content !== newContent) {
    writeFileSync(file, newContent, 'utf8');
    changedCount++;
    console.log('Updated: ' + file);
  }
});

console.log('Total files updated: ' + changedCount);
