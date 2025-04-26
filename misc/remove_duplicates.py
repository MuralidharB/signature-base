import re
import sys

def fix_duplicate_yara_rules(input_file, output_file):
    with open(input_file, 'r', errors='ignore') as f:
        lines = f.readlines()

    rule_name_pattern = re.compile(r'\brule\s+(\w+)')
    rule_name_counts = {}
    fixed_lines = []

    for line in lines:
        match = rule_name_pattern.search(line)
        if match:
            original_name = match.group(1)
            if original_name not in rule_name_counts:
                rule_name_counts[original_name] = 0
                fixed_lines.append(line)
            else:
                rule_name_counts[original_name] += 1
                new_name = f"{original_name}_{rule_name_counts[original_name]}"
                # Replace the rule name only in this line
                new_line = line.replace(f"rule {original_name}", f"rule {new_name}")
                fixed_lines.append(new_line)
        else:
            fixed_lines.append(line)

    with open(output_file, 'w') as f:
        f.writelines(fixed_lines)

    print(f"[+] Finished fixing rules. Output written to: {output_file}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python fix_yara_duplicates.py <input_yara_file> <output_yara_file>")
        sys.exit(1)

    input_yara = sys.argv[1]
    output_yara = sys.argv[2]

    fix_duplicate_yara_rules(input_yara, output_yara)

