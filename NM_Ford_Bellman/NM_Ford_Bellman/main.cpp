//
//  main.cpp
//  NM_Ford_Bellman
//
//  Created by Иван on 25/10/2018.
//

#include <iostream>
#include <fstream>
#include <vector>

#define INF 100
#define input_file_path "input.txt"

using namespace std;

struct edge
{
    int a, b, weight;
};

vector <edge> edges;
bool directed_graph;

void WritingFromFileToVector(string file_path, vector <edge> *e, int *n)
{
    ifstream input_file;
    input_file.open(file_path);
    
    if (!input_file.is_open())
    {
        cout << "ERROR!! The file isn't open" << endl;
    }
    else
    {
        int m, a, b, w;
        input_file >> *n >> m>>directed_graph;
        
        (*e).resize(m);
        
        
        for (int i=0;i<m;i++)
        {
            input_file >> a >> b >> w;
            
            a--;
            b--;
            
            (*e)[i].a = a;
            (*e)[i].b = b;
            (*e)[i].weight = w;
            
        }
    }
    
    input_file.close();
}

void OutputVector(vector <int> x);


void FordBellman(vector <edge> e, int count_of_vertexes, int count_of_edges)
{
    vector <int> d(count_of_vertexes, INF);
    d[0] = 0;
    
    bool smt_changed = true;
    int iterations = 0;
    
    for (int i = 0; i < count_of_vertexes && (smt_changed == true); i++) // просто n раз
    {
        smt_changed = false;
        
        for (int j = 0; j < count_of_edges; j++) // по всем ребрам
            if (d[e[j].a]<INF) // если путь в <a> есть
            {
                if (d[e[j].b]>d[e[j].a] + e[j].weight) // пытаемся улучшить значение d[b] значемнием d[a] + weight(a,b), используя текущий ответ для вершины a.
                {
                    d[e[j].b] = d[e[j].a] + e[j].weight; // d[y] = min (d[y] + w(a, b))
                    smt_changed = true;
                }
                if (!directed_graph)
                    if (d[e[j].a]>d[e[j].b] + e[j].weight) // пытаемся улучшить значение d[b] значемнием d[a] + weight(a,b), используя текущий ответ для вершины a.
                    {
                        d[e[j].a] = d[e[j].b] + e[j].weight; // d[y] = min (d[y] + w(a, b))
                        smt_changed = true;
                    }
                iterations++;
            }
    }
    if (iterations == count_of_vertexes) // Если на n-й итерации что-то изменилось, то в графе присутсвует ОТРИЦАТЕЛЬНЫЙ ЦИКЛ
        cout << "There is negative cycle!!" << endl;
    else
    {
     
     OutputVector(d);
        cout << endl << iterations << " iterations done \n";
    }
     
}

void OutputVector(vector <int> x)
{
    cout << endl<< "Minnimal Paths from 1st vertex :"<< endl;
    for (int i = 0; i < x.size(); i++)
        cout << " -> " << i + 1 <<" = "<< x[i] << endl;
}


int main(int argc, const char * argv[]) {
    // insert code here...
    int n;
    
    WritingFromFileToVector(input_file_path, &edges, &n);
    
    FordBellman(edges, n, edges.size());
    //for (int i=0;i<edges.size();i++) cout << edges[i].a<<"  "<<edges[i].b<<"  "<<edges[i].weight<<endl;
    return 0;
}
