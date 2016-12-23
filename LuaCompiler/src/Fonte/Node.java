import java.util.ArrayList;
import java.util.List;

public class Node {
    private Token info;
    private List<Node> children;
    
    public Node(){
        this(null);
    }
    
    public Node(Token info) {
        this.info = info;
        this.children = new ArrayList<>();
    }  
    
    public void addChildren(Token info){
        children.add(new Node(info));
    }
    
    public void addChildren(Node node){
        children.add(node);
    }
    
    @Override
    public String toString() {
        if (this.info != null)
        {
            print();
        }
        return "";
    }

    public void print() {
        print("", true);
    }

    private void print(String prefix, boolean isTail) {
        if(info != null && info.val != null){
            String tab = "";
            String space = "";
            if(isTail){
                tab = "└── ";
                space ="    ";
            } else{
                tab = "├── ";
                space = "│   ";
            }    
            System.out.println(prefix + tab + info.val);
            for (int i = 0; i < children.size() - 1; i++) {
                if(children.get(i) != null){
                    children.get(i).print(prefix + space, false);
                }
            }
            if (children.size() > 0 && children.get(children.size() - 1) != null) {
                children.get(children.size() - 1).print(prefix + space, true);
            }
        }
    }
}
