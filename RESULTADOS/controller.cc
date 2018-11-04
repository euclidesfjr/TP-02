#include <iostream>
#include "controller.hh"
#include "timestamp.hh"
#include <math.h>

using namespace std;

bool slow_start = true;
double the_window_size = 10.0;
//Menor tempo BBR.RTProp
double menor_ack = 99999; 
//salva menor RTT para avoidance
double menor_rtt = 99999; 

/* Default constructor */
Controller::Controller( const bool debug )
  : debug_( debug )
{}

/* Get current window size, in datagrams */
unsigned int Controller::window_size()
{
  if ( debug_ ) {
    cerr << "At time " << timestamp_ms()
	 << " window size is " << the_window_size << endl;
  }
 
  return the_window_size;
}

/* A datagram was sent */
void Controller::datagram_was_sent( const uint64_t sequence_number,
				    /* of the sent datagram */
				    const uint64_t send_timestamp,
                                    /* in milliseconds */
				    /*Adicionado opção de reenvio após um timeout*/
				    const bool after_timeout
				    /* datagram was sent because of a timeout */ )
{
  /* Default: take no action */

  if ( debug_ ) {
    cerr << "At time " << send_timestamp
	 << " sent datagram " << sequence_number << " (timeout = " << after_timeout << ")\n";
  }
}

/* An ack was received */
void Controller::ack_received( const uint64_t sequence_number_acked,
			       /* what sequence number was acknowledged */
			       const uint64_t send_timestamp_acked,
			       /* when the acknowledged datagram was sent (sender's clock) */
			       const uint64_t recv_timestamp_acked,
			       /* when the acknowledged datagram was received (receiver's clock)*/
			       const uint64_t timestamp_ack_received )
                   /* when the ack was received (by sender) */
{

//Variável que recebe o RTT atual, através da subtração entre timestam recebido e enviado
uint64_t rtt_atual = timestamp_ack_received - send_timestamp_acked;
        
//Variável recebe o tempo de recebimento acknowledged datagram 
int64_t tempo_atual_ack = recv_timestamp_acked - send_timestamp_acked;
    
    //salva o menor acknowledged datagram 
    if (tempo_atual_ack < menor_ack) {
	menor_ack = tempo_atual_ack;
	}
    
    //salva o menor rtt
    if (rtt_atual < menor_rtt) {
	menor_rtt = rtt_atual;
	}

    /*DELCARAÇÃO DE VARIÁVEIS LOCAIS PARA TRATAR "Menor One Way Delay"
    menor_ack_rtt = Calcula a menor OWD do menor RTT */
    double menor_ack_rtt = (menor_rtt/2);
    //Valor One Way time
    double valor_owt = (tempo_atual_ack - menor_ack) + menor_ack_rtt;

    if (valor_owt > 1.45 * menor_ack_rtt) {
	the_window_size -= 0.25;
	}
    else 
	{
		the_window_size += 0.25;
	}

    if (the_window_size < 2) {
	the_window_size = 2;
        }
    else if (the_window_size > 100) {
		the_window_size = 100;
		}

//IMPLEMENTAÇÃO TCP VENO
//REFERÊNCIA..: http://dl.acm.org/citation.cfm?id=956989 - TCP Models in ns-3
/* N = Atual.(RTT - BaseRTT)
     = Diff.BaseRTT
onde:
     Diff = Experado - atual
          = ((cWnd / BaseRTT) - (cWnd / RTT))
============================================================================*/
//CALCULO  DO RTO 

/* RTT measurement  */
//#u32     srtt;      /* smoothed round trip time << 3        */
//u32     mdev;      /* medium deviation                     */
//u32     mdev_max;  /* maximal mdev for the last rtt period */
//u32     rttvar;    /* smoothed mdev_max                    */
//u32     rtt_seq;   /* sequence number to update rttvar     */

/*tcp_set_rto()
tcp_rtt_estimator()
static void tcp_rtt_estimator(struct sock *sk, const __u32 mrtt);
mrtt -= (tp->srtt >> 3);
srtt += mrtt;
//mrttB = mrtt - srtt/8;

//srtt = srtt + mrttB = srtt + mrtt - srtt/8 = 7/8 * srtt + mrtt
mrtt -= (tp->mdev >> 2);
tp->mdev += mrtt;

if (tp->mdev > tp->mdev_max) {
    tp->mdev_max = tp->mdev;
    if (tp->mdev_max > tp->rttvar)
        tp->rttvar = tp->mdev_max;
}
 
*/
  /* Default: take no action */
  if ( debug_ ) {
    cerr << "At time " << timestamp_ack_received
	 << " received ack for datagram " << sequence_number_acked
	 << " (send @ time " << send_timestamp_acked
	 << ", received @ time " << recv_timestamp_acked << " by receiver's clock)"
	 << endl;
  }
}

/* How long to wait (in milliseconds) if there are no acks
   before sending one more datagram */
unsigned int Controller::timeout_ms()
{
  return 80; /* timeout of one second */
}
