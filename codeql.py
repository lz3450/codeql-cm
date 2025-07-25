import sys
import subprocess

CODEQL_CLI_PATH = "codeql"


def run_codeql_query(ql_file: str, output_file: str = "results.bqrs", db_path: str = "db") -> None:
    command = [CODEQL_CLI_PATH, "query", "run", "--output=results.bqrs", f"--database={db_path}", "--threads=0", "--", ql_file]

    print(f"Running CodeQL query: {' '.join(command)}")

    try:
        subprocess.run(command, check=True)
        print(f"Query executed successfully. Results saved to {output_file}")
    except subprocess.CalledProcessError as e:
        print(f"Failed to run query: {e}")
        sys.exit(1)


def interpret_results(bqrs_file: str, output_file: str = "results.csv") -> None:
    command = [CODEQL_CLI_PATH, "bqrs", "decode", f"--output={output_file}", "--format=csv", "--", bqrs_file]

    print(f"Interpreting results: {' '.join(command)}")

    try:
        subprocess.run(command, check=True)
        print(f"Results interpreted successfully. CSV saved to {output_file}")
    except subprocess.CalledProcessError as e:
        print(f"Failed to interpret results: {e}")
        sys.exit(1)


if __name__ == "__main__":
    result_file = "results.bqrs"
    run_codeql_query("queries/test0_1.ql", result_file)
    interpret_results(result_file)
