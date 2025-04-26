import re

def remove_filename_rules(input_yara_path, output_yara_path):
    with open(input_yara_path, 'r', errors='ignore') as infile:
        lines = infile.readlines()

    output_lines = []
    current_rule = []
    inside_rule = False
    rule_should_be_removed = False

    for line in lines:
        stripped = line.strip()

        if stripped.startswith('rule '):
            inside_rule = True
            current_rule = [line]
            rule_should_be_removed = False
            continue

        if inside_rule:
            current_rule.append(line)
            if re.search(r'\b(filename|extension|filepath|md5|sha1|sha256)\b', stripped, re.IGNORECASE):
                rule_should_be_removed = True
            if stripped == '}':
                if not rule_should_be_removed:
                    output_lines.extend(current_rule)
                inside_rule = False
                current_rule = []
        else:
            output_lines.append(line)

    with open(output_yara_path, 'w') as outfile:
        outfile.writelines(output_lines)

    print(f"[+] Finished writing memory-safe YARA to: {output_yara_path}")

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 3:
        print("Usage: python remove_filename_yara.py <input_yara_file> <output_yara_file>")
    else:
        remove_filename_rules(sys.argv[1], sys.argv[2])

