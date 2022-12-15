char[] al = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
String chain = "bfjenriuosijgzingvikxuiruezapjgmpwnwbbcsioapeurhgbkjrozpknvjjdjatetyuriohfjdkbnvxcjoshfijeiz";
int cle;

void setup() {
  if (cle == 0) {
    for (int i=0; i<26; i++) {
      cle = i;
      int[] numChain = CharToNum(chain);
      numChain = ApplyCle(numChain);
      println("cle : "+cle, CleToString(numChain));
    }
  } else {
    int[] numChain = CharToNum(chain);
    numChain = ApplyCle(numChain);
    println("cle : "+cle, CleToString(numChain));
  }
}




int whichletter(char c) {
  int compteur = 0;

  for (char f : al) {

    if (c == f) {
      return compteur;
    }

    compteur++;
  }

  return 0;
}

int[] CharToNum(String h) {
  int[] nums = new int[h.length()];

  for (int i=0; i<h.length(); i++) {
    nums[i] = whichletter(h.charAt(i));
  }

  return nums;
}

int[] ApplyCle(int[] nums) {
  int[] newnums = new int[nums.length];

  for (int i=0; i<nums.length; i++) {
    int a = nums[i];
    a += cle;
    a %= 26;
    newnums[i] = a;
  }

  return newnums;
}

String CleToString(int[] nums) {
  String ch = "";

  for (int i=0; i<nums.length; i++) {
    char a = al[nums[i]];
    ch += a;
  }

  return ch;
}
