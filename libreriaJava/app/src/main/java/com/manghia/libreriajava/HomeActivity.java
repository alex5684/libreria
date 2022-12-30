package com.manghia.libreriajava;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class HomeActivity extends AppCompatActivity {

    Spinner SSelezioneClasse;
    FirebaseDatabase database;
    List<String> listaChiavi=new ArrayList<>();
    JSONObject jsonObject=null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        SSelezioneClasse=findViewById(R.id.selezioneClasse);
        database=FirebaseDatabase.getInstance();
        DatabaseReference reference = database.getReference();

        reference.get().addOnCompleteListener(new OnCompleteListener<DataSnapshot>() {
            @Override
            public void onComplete(@NonNull Task<DataSnapshot> task) {
                if(task.isSuccessful())
                {
                    try {
                        jsonObject=new JSONObject(new Gson().toJson(task.getResult().getValue(Object.class)));
                        for (Iterator<String> it = jsonObject.keys(); it.hasNext(); )
                        {
                            String var = it.next();
                            listaChiavi.add(var);
                        }
                        //fatto una funzione perchè scrivendola qua non funziona
                        setAdapter();
                    } catch (JSONException e) {
                        e.printStackTrace();
                        Toast.makeText(getApplicationContext(),e.toString(),Toast.LENGTH_LONG).show();
                    }
                }
            }
        });
    }

    private void setAdapter()
    {
        ArrayAdapter<String> dataAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, listaChiavi);
        // Drop down layout style - list view with radio button
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        SSelezioneClasse.setAdapter(dataAdapter);
    }
}