from pathlib import Path


def mailpasswd(account):
    path = Path(f"/home/ubunteous/.nix.d/home/mail/{account}.gpg")
    args = ["gpg", "--use-agent", "--quiet", "--batch", "-d", path]
    try:
        return subprocess.check_output(args).strip()
    except subprocess.CalledProcessError:
        return ""
