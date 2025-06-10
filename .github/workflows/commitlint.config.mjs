// commitlint.config.mjs
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // 移除 type-enum 限制，允許任意 type
    'type-enum': [0], // 禁用 type 限制
    'header-max-length': [2, 'always', 100],
    'subject-empty': [2, 'never'],
    // 禁用原有規則，因為我們有自定義需求
    'subject-case': [0],
    'subject-full-stop': [0],
    'type-case': [0], // 也移除 type-case 限制，允許 WIP: 這樣的格式
    'type-empty': [0], // 允許沒有 type 的 commit message
    // 自定義規則：要求 commit message 必須以 #<issue number> 結尾（除了特殊情況）
    'issue-number-required': [2, 'always']
  },
  plugins: [
    {
      rules: {
        'issue-number-required': (parsed) => {
          // 檢查 parsed 物件是否存在且有 header 屬性
          if (!parsed || !parsed.header) {
            return [false, 'Commit message could not be parsed'];
          }

          const header = parsed.header;

          // 檢查是否是 release-please 產生的 commit (chore(main) 開頭)
          const releaseCommitRegex = /^chore\(main\):/;
          if (releaseCommitRegex.test(header)) {
            return [true, '']; // release-please commit 不需要 issue number
          }

          // 檢查是否以 #數字 結尾
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