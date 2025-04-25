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
    if (key === 'show' || key === 'table' || key === 'query' || key === 'compare' || key === 'path') {
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
  console.log('bun run index.ts --show=fk');
  console.log('bun run index.ts --show=fk --table=TABLE_NAME');
  console.log('bun run index.ts --show=sequences');
  console.log('bun run index.ts --show=pk --table=TABLE_NAME');
  console.log('bun run index.ts --show=schema');
  console.log('bun run index.ts --query=path/to/query.sql');
  console.log('bun run index.ts --compare=csv --path=BACKUP_DIRECTORY');
}
