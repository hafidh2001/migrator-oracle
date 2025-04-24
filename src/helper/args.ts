import type { CommandArgs } from './types';

export function parseArgs(): CommandArgs {
  const args = process.argv.slice(2);
  const result: CommandArgs = {};
  
  args.forEach(arg => {
    if (arg === '--help') {
      result.help = true;
      return;
    }
    const [key, value] = arg.replace('--', '').split('=');
    if (key === 'show' || key === 'table') {
      result[key] = value;
    }
  });
  
  return result;
}

export function showHelp(): void {
  console.log('\nAvailable commands:');
  console.log('------------------');
  console.log('bun run index.ts --show=tables');
  console.log('bun run index.ts --show=structure --table=TABLE_NAME');
  console.log('bun run index.ts --show=relations');
  console.log('bun run index.ts --show=relations --table=TABLE_NAME');
  console.log('bun run index.ts --show=sequences');
}
