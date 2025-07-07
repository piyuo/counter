// commitlint.config.mjs
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Remove type-enum restriction, allow any type
    'type-enum': [0], // Disable type restriction
    'header-max-length': [2, 'always', 100],
    'type-case': [0], // Also remove type-case restriction, allow formats like WIP:
    // Custom rule: require commit message to end with #<issue number> (except special cases)
    'issue-number-required': [2, 'always']
  },
  plugins: [
    {
      rules: {
        'issue-number-required': (parsed) => {
          // Check if parsed object exists and has header property
          if (!parsed || !parsed.header) {
            return [false, 'Commit message could not be parsed'];
          }

          const header = parsed.header;

          // Check if it's a release-please generated commit (starts with chore(main))
          const releaseCommitRegex = /^chore\(main\):/;
          if (releaseCommitRegex.test(header)) {
            return [true, '']; // release-please commits don't need issue numbers
          }

          // Check if it ends with #number
          const issueNumberRegex = / #\d+$/;

          if (!issueNumberRegex.test(header)) {
            return [
              false,
              'Commit message must end with " #<issue-number>" (e.g., "feat: add feature #123", "WIP: working on feature #456"). Exception: chore(main) commits do not require issue numbers.'
            ];
          }

          return [true, ''];
        }
      }
    }
  ]
};